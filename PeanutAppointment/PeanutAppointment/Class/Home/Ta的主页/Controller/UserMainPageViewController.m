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
#import "LocationManager.h"

#import "UserMainPageModel.h"

#import "AppointmentHerViewController.h"

@interface UserMainPageViewController ()

@property (nonatomic, strong) CLLocation *location;//当前定位
@property (nonatomic, strong) UserMainPageModel *model;

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
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"Ta的主页"];
    [self setNavStyle:CustomNavStyle_Default];
    [self.customNavBar setRightButtonWithTitle:@"举报" titleColor:COLOR_UI_222222];
}

- (void)updateUI {
    if (self.model == nil) {
        return;
    }
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageHeadView getHeightWithModel:self.model]);
    [self.headView setModel:self.model];
    self.tableView.tableHeaderView = self.headView;
    
    if (self.model.skillInfo) {
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageFootView getHeightWithModel:self.model.skillInfo]);
        [self.footView setModel:self.model.skillInfo];
        self.tableView.tableFooterView = self.footView;
    }
    
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


#pragma mark - network
//userId：用户id pusId：用户与技能id （pusId非必传，如果不传就不用把pusId带上）
//lng: 经度 lat:纬度

- (void)getData {
    if (_location) {
        
        [SVProgressHUD show];
        NSDictionary *param = @{@"userId":_userId?:@"", @"pusId":_pusId?:@"", @"lng":@(_location.coordinate.longitude), @"lat":@(_location.coordinate.latitude)};
        [YQNetworking postWithApiNumber:API_NUM_20032 params:param successBlock:^(id response) {
            [SVProgressHUD dismiss];
            if (getResponseIsSuccess(response)) {
                self.model = [UserMainPageModel mj_objectWithKeyValues:getResponseData(response)];
                [self updateUI];
            }
        } failBlock:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
        [self getLocationToRequest:NO];
    } else {
        [self getLocationToRequest:YES];
    }
}

#pragma mark - private
///获取位置信息 request 是否需要获取数据
- (void)getLocationToRequest:(BOOL)request {
    [[LocationManager sharedManager].locationManager requestLocationWithReGeocode:NO withNetworkState:NO completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        if (!error) {
            self.location = location.location;
            if (request) {
                [self getData];
            }
        } else {// TODO  暂时这样处理的，百度地图key有问题
#warning 后面改
            self.location = [[CLLocation alloc] initWithLatitude:29.678 longitude:106.67328];
            if (request) {
                [self getData];
            }
        }
    }];
}

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
        _headView = [[UserMainPageHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageHeadView getHeightWithModel:nil])];
    }
    return _headView;
}

- (UserMainPageFootView *)footView {
    if (!_footView) {
        _footView = [[UserMainPageFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [UserMainPageFootView getHeightWithModel:nil])];
    }
    return _footView;
}



@end
