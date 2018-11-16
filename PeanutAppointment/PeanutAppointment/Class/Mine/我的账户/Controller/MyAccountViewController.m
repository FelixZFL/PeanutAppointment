//
//  MyAccountViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountHeadView.h"
#import "MyAccountCell.h"

#import "MyAccountInfoModel.h"


#import "BillListViewController.h"
#import "CardAuthViewController.h"
#import "RechargeViewController.h"
#import "WithdrawalViewController.h"
#import "ChangePasswordViewController.h"

@interface MyAccountViewController ()

@property (nonatomic, strong) MyAccountHeadView *headView;
@property (nonatomic, strong) MyAccountInfoModel *model;

@end

@implementation MyAccountViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = COLOR_UI_FFFFFF;
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    
    CGFloat headHeight = [MyAccountHeadView getHeight];
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(headHeight);
    }];
    
    
    CGFloat btnH = BUTTON_HEIGHT_50;
    UIView *btnView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(btnH);
    }];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = KFont(14);
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * SCREEN_WIDTH/2);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.top.bottom.mas_equalTo(0);
        }];
        if (i == 0) {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_222222 forState:UIControlStateNormal];
            [btn setborderColor:COLOR_UI_999999];
            [btn setButtonStateNormalTitle:@"提现"];
        } else {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"充值"];
        }
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headHeight);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - btnH);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"我的账户"];
    [self setNavStyle:CustomNavStyle_Light];
    [self.customNavBar setBackgroundAlpha:0];
    [self.view bringSubviewToFront:self.customNavBar];
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20004 params:@{@"phone":[PAUserDefaults getUserBoundPhone]} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            MyAccountInfoModel *model = [MyAccountInfoModel mj_objectWithKeyValues:getResponseData(response)];
            self.model = model;
            [self.headView updateWithModel:model];
            [self.tableView reloadData];
        }
        
    } failBlock:^(NSError *error) {
    }];
}


#pragma mark - action

- (void)btnAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"提现"]) {
        
        if (self.model) {
             if ([self.model.idCard integerValue] == 1) {
                 //已实名认证  进入提醒界面
                 WithdrawalViewController *vc = [[WithdrawalViewController alloc] init];
                 [vc setSubmitSuccessBlock:^{
                     [self getData];
                 }];
                 [self.navigationController pushViewController:vc animated:YES];
                
            } else if ([self.model.idCard integerValue] == 2) {
                [SVProgressHUD showInfoWithStatus:@"身份认证正在审核中"];
            } else {
                [SVProgressHUD showInfoWithStatus:@"需要先进行实名认证"];
                //身份证认证
                CardAuthViewController *vc = [[CardAuthViewController alloc] init];
                [vc setSubmitSuccessBlock:^{
                    [self getData];
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
        
    } else if ([sender.titleLabel.text isEqualToString:@"充值"]) {
        
        RechargeViewController *vc = [[RechargeViewController alloc] init];
        [vc setSubmitSuccessBlock:^{
            [self getData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyAccountCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [MyAccountCell reuseIdentifier];
    MyAccountCell *cell = (MyAccountCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"账单";
        [cell.nextBtn setTitle:@"查看详情"];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"身份证认证";
        NSString *status = @"";
        if (self.model) {
            if ([self.model.idCard integerValue] == 0) {
                status = @"未认证";
            } else if ([self.model.idCard integerValue] == 1) {
                status = @"已认证";
            } else if ([self.model.idCard integerValue] == 2) {
                status = @"待审核";
            } else if ([self.model.idCard integerValue] == 3) {
                status = @"审核失败";
            }
        }
        [cell.nextBtn setTitle:status];
        
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"账户安全及密码修改";
        [cell.nextBtn setTitle:@"修改"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        //账单
        BillListViewController *vc = [[BillListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 1) {
        if (self.model && ([self.model.idCard integerValue] == 0 || [self.model.idCard integerValue] == 3)) {
            //身份证认证
            CardAuthViewController *vc = [[CardAuthViewController alloc] init];
            [vc setSubmitSuccessBlock:^{
                [self getData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } else if (indexPath.row == 2) {
        //账户安全及密码修改
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - getter

- (MyAccountHeadView *)headView {
    if (!_headView) {
        _headView = [[MyAccountHeadView alloc] init];
    }
    return _headView;
}

@end
