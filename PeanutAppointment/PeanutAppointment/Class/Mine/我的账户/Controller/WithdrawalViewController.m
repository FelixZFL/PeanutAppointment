//
//  WithdrawalViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "RechargeTypeCell.h"
#import "PasswordAlertView.h"

#import "MyAccountInfoModel.h"

#import "ChangePasswordViewController.h"

@interface WithdrawalViewController ()

@property (nonatomic, strong) MyAccountInfoModel *model;

@property (nonatomic, strong) UITextField *moneyTF;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation WithdrawalViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
    [self getMoneyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"提现"];
    
}

- (void)setupUI {
    
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.selectIndex = 0;
    self.tableView.rowHeight = [RechargeTypeCell getCellHeight];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    headView.backgroundColor = COLOR_UI_FFFFFF;
    [headView addSubview:self.moneyTF];
    [self.moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    __weak __typeof(self)weakSelf = self;
    UILabel *moneyLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentCenter];
    moneyLabel.text = @"可提余额￥0.00";
    [headView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.moneyTF.mas_bottom).with.mas_offset(MARGIN_5);
    }];
    self.moneyLabel = moneyLabel;
    
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
    hintLabel.text = @"提现说明:1、最少提现金额为100元，每次提现收取3.98%%手续费。（最终解释权归本APP所有）。2、申请后到账时间48小时内，节假日顺延。（特殊情况除外）";
    [footView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(confirmBtn.mas_bottom).with.mas_offset(MARGIN_15);
    }];
    
    self.tableView.tableFooterView = footView;
    
    
}

#pragma mark - network -

- (void)getMoneyData {
    [YQNetworking postWithApiNumber:API_NUM_20004 params:@{@"phone":[PAUserDefaults getUserBoundPhone]} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            MyAccountInfoModel *model = [MyAccountInfoModel mj_objectWithKeyValues:getResponseData(response)];
            self.model = model;
            self.moneyLabel.text = [NSString stringWithFormat:@"可提余额￥%@",model.balanceOutstanding?:@""];
        }
        
    } failBlock:^(NSError *error) {
    }];
}

#pragma mark - action -

- (void)confirmAction {
    
    if (self.moneyTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
        return;
    }
    if ([self.moneyTF.text doubleValue] < 100) {
        [SVProgressHUD showErrorWithStatus:@"提现金额需要大于一百"];
        return;
    }
    //再判断 账户余额
    if (!self.model || [self.moneyTF.text doubleValue] > [self.model.balanceOutstanding doubleValue]) {
        [SVProgressHUD showErrorWithStatus:@"没有足够的可提现余额"];
        return;
    }
    
    if (self.model.withdrawPassword.length > 0) {
        
        __block PasswordAlertView *alert = [PasswordAlertView alertWithTitle:@"请设置支付密码" Block:^(NSString *pwd) {
            if ([pwd isEqualToString:self.model.withdrawPassword]) {
                [self withdrawalAction];
                [alert removFromWindow];
            } else {
                [SVProgressHUD showErrorWithStatus:@"密码不正确"];
            }
            
        }];
        [alert showInWindow];
        
    } else {
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        [vc setSubmitSuccessBlock:^{
            //[self withdrawalAction];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)withdrawalAction {
    //userId：用户id，money：提现金额 ，moneyType：提现类型（1：支付宝/2：微信）
    NSString *withdrawalMoney = [NSString stringWithFormat:@"%.2f",[self.moneyTF.text doubleValue]];
    NSString *userId = [PATool getUserId];
    [YQNetworking postWithApiNumber:API_NUM_10003 params:@{@"userId":userId,@"money":withdrawalMoney,@"moneyType":self.selectIndex == 0 ? @"1" : @"2"} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            
            NSDictionary *dic = getResponseData(response);
            if ([dic[@"isSuccess"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"提现申请成功"];
                if (self.submitSuccessBlock) {
                    self.submitSuccessBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            } else if ([dic[@"isSuccess"] integerValue] == 2){
                [SVProgressHUD showErrorWithStatus:@"余额不足"];
            }
            
        }
        
    } failBlock:nil];
    
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

#pragma mark - getter -

- (UITextField *)moneyTF {
    if (!_moneyTF) {
        _moneyTF = [[UITextField alloc] init];
        _moneyTF.font = KFont(14);
        _moneyTF.textColor = COLOR_UI_666666;
        _moneyTF.placeholder = @"输入提现金额";
        _moneyTF.textAlignment = NSTextAlignmentCenter;
        _moneyTF.keyboardType = UIKeyboardTypeNumberPad;
        //_moneyTF.delegate = self;
        [_moneyTF setDefaultCorner];
        [_moneyTF setborderColor:COLOR_UI_999999];
    }
    return _moneyTF;
}


@end
