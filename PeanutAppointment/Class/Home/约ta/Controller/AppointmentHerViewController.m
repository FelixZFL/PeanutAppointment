//
//  AppointmentHerViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/25.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AppointmentHerViewController.h"
#import "AppointmentHerHeadView.h"

@interface AppointmentHerViewController ()

@property (nonatomic, strong) AppointmentHerHeadView *headView;

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
    
    self.tableView.tableHeaderView = self.headView;
    
    UIButton *releaseBtn = [[UIButton alloc] init];
    [releaseBtn setButtonStateNormalTitle:@"发布需求" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    releaseBtn.backgroundColor = COLOR_UI_THEME_RED;
    [releaseBtn addTarget:self action:@selector(releaseBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:releaseBtn];
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
}

- (void)setupNav {
    [self.customNavBar setTitle:@"约Ta"];
}


#pragma mark - network



#pragma mark - action

- (void)releaseBtnClickAction:(UIButton *)sender {
    
}

#pragma mark - getter

- (AppointmentHerHeadView *)headView {
    if (!_headView) {
        _headView = [[AppointmentHerHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AppointmentHerHeadView getHeight])];
    }
    return _headView;
}

@end
