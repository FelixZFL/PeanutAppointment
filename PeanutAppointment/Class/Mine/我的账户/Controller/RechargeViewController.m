//
//  RechargeViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTypeCell.h"
#import "PayManager.h"

#import "PayResultViewController.h"

@interface RechargeViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL isHaveDian;
@property (nonatomic, assign) BOOL isFirstZero;

@property (nonatomic, strong) UITextField *moneyTF;

@property (nonatomic, assign) NSInteger selectIndex;


@property (nonatomic, strong) NSString *rechargeMoney;

@end

@implementation RechargeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"充值"];
    
}

- (void)setupUI {
    
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.selectIndex = 0;
    self.tableView.rowHeight = [RechargeTypeCell getCellHeight];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedAction:)]];
    headView.backgroundColor = COLOR_UI_FFFFFF;
    [headView addSubview:self.moneyTF];
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    [self.moneyTF becomeFirstResponder];
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
    
    self.tableView.tableHeaderView = headView;
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    
    UIView *footLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [footView addSubview:footLine];
    [footLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn setButtonStateNormalTitle:@"确定" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
    confirmBtn.backgroundColor = COLOR_UI_THEME_RED;
    [confirmBtn setDefaultCorner];
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(footLine.mas_bottom).with.mas_offset(MARGIN_15);
        make.height.mas_equalTo(BUTTON_HEIGHT_42);
    }];
    
    UILabel *hintLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
    hintLabel.numberOfLines = 0;
    hintLabel.text = @"充值须知:1、建议充值足量金额，方便及时下单预约服务者  2、充值金额可以用于下单支付或者提现  3、如有疑问请咨询客服QQ3149964075";
    [footView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(confirmBtn.mas_bottom).with.mas_offset(MARGIN_15);
    }];
    
    self.tableView.tableFooterView = footView;
    
    
}

#pragma mark - action -

- (void)confirmAction {
    
    if (self.moneyTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额"];
        return;
    }
    if ([self.moneyTF.text doubleValue] < 0.01) {
        [SVProgressHUD showErrorWithStatus:@"充值金额需要大于一分"];
        return;
    }
    [self.view endEditing:YES];
    
    [self payAction];
}

- (void)payAction {
    self.rechargeMoney = [NSString stringWithFormat:@"%.2f",[self.moneyTF.text doubleValue]];
    //userId：用户id，money：充值金额 ，moneyType：充值类型（1：支付宝/2：微信）
    [YQNetworking postWithApiNumber:API_NUM_10004 params:@{@"userId":[PATool getUserId],@"money":self.rechargeMoney,@"moneyType":self.selectIndex == 0 ? @"1" : @"2"} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            if (0 == self.selectIndex) {
                [[PayManager sharedManager] alipayStartPay:[getResponseData(response) objectForKey:@"orderString"]];
            } else {
                WXReqModel *pay = [WXReqModel mj_objectWithKeyValues:getResponseData(response)];
                [[PayManager sharedManager] wxPayStartPay:pay];
            }
        }
        
    } failBlock:nil];
    
}

#pragma mark - private -
- (void)tapGesturedAction:(UIGestureRecognizer *)gesture {
    
    [self.view endEditing:YES];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPayResult:) name:NotificationName_PAY_RESULT object:nil];
}

- (void)getPayResult:(NSNotification *)notif {
    
    NSDictionary *dic = notif.object;
    
    BOOL success = NO;
    NSString *reason = @"";
    if ([[dic objectForKey:@"type"] isEqualToString:@"alipay"]) {//支付宝
        
        if ([[dic objectForKey:@"status"] integerValue] == 1) {//支付成功
            success = YES;
        }else{
            reason = @"支付宝支付失败";
        }
        
    }else{//微信
        
        if ([[dic objectForKey:@"status"] integerValue] == 1) {
            success = YES;
        }else {
            reason = @"微信支付失败";
        }
    }
    
    PayResultViewController *vc = [[PayResultViewController alloc] init];
    vc.isSuccess = success;
    vc.money = [NSString stringWithFormat:@"￥%.2f",[self.moneyTF.text doubleValue]];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.moneyTF.text = @"";//清空输入框内容
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [RechargeTypeCell reuseIdentifier];
    RechargeTypeCell *cell = (RechargeTypeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RechargeTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.typeImgV.image = imageNamed(@"payType_alipay");
        cell.typeLabel.text = @"支付宝";
    }else if (indexPath.row == 1) {
        cell.typeImgV.image = imageNamed(@"payType_wechat");
        cell.typeLabel.text = @"微信";
    }
    
    cell.selectImgV.image = imageNamed(self.selectIndex == indexPath.row ? @"payType_select" : @"payType_unselect");
    cell.bottomLine.hidden = indexPath.row == 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectIndex == indexPath.row) {
        return;
    }
    self.selectIndex = indexPath.row;
    [self.tableView reloadData];
}


#pragma mark - UITextFieldDelegate -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian = NO;
    }
    if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
        _isFirstZero = NO;
    }
    
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            
            if([textField.text length]==0){
                if(single == '.'){
                    //首字母不能为小数点
                    return NO;
                }
                if (single == '0') {
                    _isFirstZero = YES;
                    return YES;
                }
            }
            
            if (single=='.'){
                if(!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian=YES;
                    return YES;
                }else{
                    return NO;
                }
            }else if(single=='0'){
                if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                    //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                    if([textField.text isEqualToString:@"0.0"]){
                        return NO;
                    }
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=(int)(range.location-ran.location);
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }else if (_isFirstZero&&!_isHaveDian){
                    //首位有0没.不能再输入0
                    return NO;
                }else{
                    return YES;
                }
            }else{
                if (_isHaveDian){
                    //存在小数点，保留两位小数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt= (int)(range.location-ran.location);
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(_isFirstZero&&!_isHaveDian){
                    //首位有0没点
                    return NO;
                }else{
                    return YES;
                }
            }
        }else{
            //输入的数据格式不正确
            return NO;
        }
    }else{
        return YES;
    }
}

#pragma mark - getter -

- (UITextField *)moneyTF {
    if (!_moneyTF) {
        _moneyTF = [[UITextField alloc] init];
        _moneyTF.font = KFont(14);
        _moneyTF.textColor = COLOR_UI_666666;
        _moneyTF.placeholder = @"输入充值金额";
        _moneyTF.textAlignment = NSTextAlignmentCenter;
        _moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
        _moneyTF.delegate = self;
        [_moneyTF setDefaultCorner];
        [_moneyTF setborderColor:COLOR_UI_999999];
    }
    return _moneyTF;
}


@end
