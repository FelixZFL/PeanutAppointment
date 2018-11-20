//
//  AppointmentHerViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/25.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AppointmentHerViewController.h"
#import "AppointmentHerHeadView.h"
#import "HomeIndexUserModel.h"

#import "SkillListModel.h"
#import "UserMainPageModel.h"

#import "RechargeViewController.h"

@interface AppointmentHerViewController ()

@property (nonatomic, strong) AppointmentHerHeadView *headView;
@property (nonatomic, strong) UIButton *releaseBtn;

@property (nonatomic, strong) NSArray *skillArray;

@end

@implementation AppointmentHerViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    UIButton *releaseBtn = [[UIButton alloc] init];
    [releaseBtn setButtonStateNormalTitle:@"发布需求" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    releaseBtn.backgroundColor = COLOR_UI_THEME_RED;
    releaseBtn.hidden = YES;
    [releaseBtn addTarget:self action:@selector(releaseBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.releaseBtn = releaseBtn;
    
    [self.view addSubview:releaseBtn];
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
    
    if (_choosedUser) {
        _yUserId = _choosedUser.userId;
        [self updateUI];
        
    } else {
        //获取技能信息
        [self getData];
    }
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"约Ta"];
}

- (void)updateUI {
    
    if (_choosedUser) {
        SkillListModel *model = [[SkillListModel alloc] init];
        model.jnId = _choosedUser.pusId;
        model.jnName = _choosedUser.jnName;
        self.skillArray = @[model];
        self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [AppointmentHerHeadView getHeightWithSkills:self.skillArray]);
        [self.headView setModel:_choosedUser];
        [self.headView setSkillArray:self.skillArray];
        self.tableView.tableHeaderView = self.headView;
        self.releaseBtn.hidden = NO;
        
        
    } else {
        if (self.skillArray.count > 0) {
            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [AppointmentHerHeadView getHeightWithSkills:self.skillArray]);
            [self.headView setUserInfoModel:_userModel];
            [self.headView setSkillArray:self.skillArray];
            self.tableView.tableHeaderView = self.headView;
            self.releaseBtn.hidden = NO;
        }
    }
    
}

#pragma mark - network

- (void)getData {
    [SVProgressHUD show];
    [YQNetworking postWithApiNumber:API_NUM_20036 params:@{@"userId":_yUserId} successBlock:^(id response) {
        [SVProgressHUD dismiss];
        if (getResponseIsSuccess(response)) {
            self.skillArray = [SkillListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)];
            [self updateUI];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - action

- (void)releaseBtnClickAction:(UIButton *)sender {
    /*  jnId：技能id  有效时间：dayNumber  定金：subscription
     yUserId：应邀者id （ 多个的情况下 逗号分隔： 111,111,111,111      单个的情况下不需要加逗号）
     userId：用户id（发布者）*/
    
    NSString *jnId = self.headView.choosedPusId;
    NSString *dayNumber = self.headView.choosedVailDays;
    NSString *subscription = self.headView.choosedPrice;
    
    NSString *yUserId = _yUserId;
    
    [YQNetworking postWithApiNumber:API_NUM_10007 params:@{@"userId":[PATool getUserId],@"yUserId":yUserId,@"jnId":jnId,@"dayNumber":dayNumber,@"subscription":subscription} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            NSDictionary *dic = getResponseData(response);
            //1：发布成功  0:余额不足     （注：在用户发布需求的时候就要扣取定金金额，所以有判断）
            if ([dic[@"isSuccess"] integerValue] == 1 || [dic[@"success"] integerValue] == 1) {
                [[AlertBaseView alertWithTitle:@"发布成功" leftBtn:nil leftBlock:nil rightBtn:@"确定" rightBlock:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }] showInWindow];
            } else if ([dic[@"isSuccess"] integerValue] == 0 || [dic[@"success"] integerValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"余额不足"];
                RechargeViewController *vc = [[RechargeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } failBlock:nil];
    
}

#pragma mark - getter

- (AppointmentHerHeadView *)headView {
    if (!_headView) {
        _headView = [[AppointmentHerHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _headView;
}

@end
