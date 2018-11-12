//
//  UserMainPageViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserMainPageViewController.h"
#import "UserMainPageHeadView.h"
#import "UserMainPageFootView.h"

#import "AppointmentHerViewController.h"

@interface UserMainPageViewController ()

@property (nonatomic, strong) UserMainPageHeadView *headView;
@property (nonatomic, strong) UserMainPageFootView *footView;

@end

@implementation UserMainPageViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
    UIView *btnView = [[UIView alloc] init];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [btnView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    CGFloat btnWith = 64;
    CGFloat btnHeight = 40;
    CGFloat marginX = (SCREEN_WIDTH - MARGIN_15 * 2 - btnWith * 4)/3;
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 + i * (btnWith + marginX), MARGIN_5, btnWith, btnHeight)];
        btn.titleLabel.font = KFont(14);
        [btn setDefaultCorner];
        [btn setborderColor:COLOR_UI_THEME_RED];
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        if (i == 0) {
            [btn setButtonStateNormalTitle:@"约Ta"];
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        } else if (i == 1) {
            [btn setButtonStateNormalTitle:@"去赚钱"];
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        } else if (i == 2) {
            [btn setButtonStateNormalTitle:@"点赞"];
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
        } else if (i == 3) {
            [btn setButtonStateNormalTitle:@"分享"];
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
        }
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"Ta的主页"];
    [self setNavStyle:CustomNavStyle_Default];
    [self.customNavBar setRightButtonWithTitle:@"举报" titleColor:COLOR_UI_222222];
}


#pragma mark - network


#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"约Ta"]) {
        AppointmentHerViewController *vc = [[AppointmentHerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private -

#pragma mark - getter

- (UserMainPageHeadView *)headView {
    if (!_headView) {
        _headView = [[UserMainPageHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageHeadView getHeight])];
    }
    return _headView;
}

- (UserMainPageFootView *)footView {
    if (!_footView) {
        _footView = [[UserMainPageFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageFootView getHeight])];
    }
    return _footView;
}



@end
