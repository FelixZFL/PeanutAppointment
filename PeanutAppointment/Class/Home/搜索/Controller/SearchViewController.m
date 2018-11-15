//
//  SearchViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "SearchViewController.h"
#import "TypeChooseView.h"
#import "HomeCell.h"
#import "CommentListAlertView.h"
#import "RewardAlertView.h"
#import "RechargeAlertView.h"
#import "AlertShareView.h"
#import "LocationManager.h"

#import "HomeIndexUserModel.h"
#import "ShareDataModel.h"

#import "UserMainPageViewController.h"//ta的主页
#import "StarOfTodayViewController.h"//今日之星
#import "AppointmentHerViewController.h"//约ta



@interface SearchViewController ()<UITextFieldDelegate>

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UITextField *searchTF;

@property (nonatomic, strong) CLLocation *location;//当前定位

@end

@implementation SearchViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.selectIndex = 0;
    TypeChooseView *headView = [TypeChooseView typeViewWithTypeArr:@[@"距离",@"成交量",@"价格"] withSelectIndex:0 chooseBlock:^(NSInteger selectIndex) {
        self.selectIndex = selectIndex;
        [self.tableView.mj_header beginRefreshing];
    }];
    
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(TypeChooseViewHeight);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT + TypeChooseViewHeight + MARGIN_1);
        make.bottom.mas_equalTo(-TABBAR_HEIGHT);
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
            [btn setButtonStateNormalTitle:@"去发布需求"];
        } else {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"添加技能"];
        }
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT + TypeChooseViewHeight);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - btnH);
    }];
    
}

- (void)setupNav {
    
    [self.customNavBar setTitleView:self.searchTF];
    
    __weak __typeof(self)weakSelf = self;
    [self.customNavBar setRightButtonWithImage:imageNamed(@"main_nav_search")];
    [self.customNavBar setOnClickRightButton:^(UIButton *btn) {
        if (self.searchTF.text.length > 0) {
            NSLog(@"点击了搜索");
            //请求数据
            [weakSelf.view endEditing:YES];
            [weakSelf.tableView.mj_header beginRefreshing];
        }
    }];
}

#pragma mark - refresh -

- (void)addRefresh {
    
    self.pageNum = 0;
    self.pageSize = 10;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 0;
        [self.dataArr removeAllObjects];
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageNum += 1;
        [self getData];
    }];
    
    [self getData];
}

#pragma mark - network

- (void)getData {
    
    if (_location) {
        NSString *cjl = @"";
        NSString *price = @"";
        NSString *lng = @"";
        NSString *lat = @"";
        if (_selectIndex == 0) {
            lng = [NSString stringWithFormat:@"%f",_location.coordinate.longitude];
            lat = [NSString stringWithFormat:@"%f",_location.coordinate.latitude];
        } else if (_selectIndex == 1) {
            cjl = @"1";
        } else {
            price = @"1";
        }
        /*pasId：技能分类id  page：页数  limit：条数 cjl：1    （成交量  非必传） price：1   （价格 非必传）
         lng：（长）经度 非必传
         lat：（短）纬度：非必传
         content：搜索的内容}*/
        NSString *pasId = self.pasId?:@"";
        NSString *searchText = self.searchTF.text;
        NSDictionary *param = @{@"pasId":pasId, @"cjl":cjl, @"price":price, @"lng":lng, @"lat":lat, @"content":searchText, @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)};
        
        [YQNetworking postWithApiNumber:API_NUM_20022 params:param successBlock:^(id response) {
            if (getResponseIsSuccess(response)) {
                
                [self.dataArr addObjectsFromArray:[HomeIndexUserModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
                [self.tableView reloadData];
            }
            
            self.placeholderView.hidden = self.dataArr.count > 0;
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } failBlock:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
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

- (void)btnAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"去发布需求"]) {
        
        
    } else if ([sender.titleLabel.text isEqualToString:@"添加技能"]) {
        
    }
}


#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HomeCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [HomeCell reuseIdentifier];
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setUserInfoBlock:^(HomeIndexUserModel * _Nonnull model) {
            UserMainPageViewController *vc = [[UserMainPageViewController alloc] init];
            vc.userId = model.userId;
            vc.pusId = model.pusId;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setImageClickBlock:^(NSInteger index, HomeIndexUserModel * _Nonnull model) {
            StarOfTodayViewController *vc = [[StarOfTodayViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setBtnClickBlock:^(NSInteger index, HomeIndexUserModel * _Nonnull model, UIButton *btn) {
            if (index == 0) {//分享
                [YQNetworking postWithApiNumber:API_NUM_10023 params:@{@"userId":model.userId, @"pusId":model.pusId} successBlock:^(id response) {
                    if (getResponseIsSuccess(response)) {
                        ShareDataModel *model =[ShareDataModel mj_objectWithKeyValues:getResponseData(response)];
                        [[AlertShareView alertWithModel:model] showInWindow];
                    }
                } failBlock:nil];
            } else if (index == 1) {//评论
                [[CommentListAlertView alertWithId:model.pusId] showInWindow];
                
            } else if (index == 2) {//点赞
                [YQNetworking postWithApiNumber:API_NUM_10015 params:@{@"userId":[PATool getUserId],@"pusId":model.pusId} successBlock:^(id response) {
                    if (getResponseIsSuccess(response)) {
                        [btn setButtonStateNormalTitle:[NSString stringWithFormat:@"%ld",[btn.titleLabel.text integerValue] + 1]];
                    }
                } failBlock:nil];
            } else if (index == 3) {//打赏
                [[RewardAlertView alertWithUserId:model.userId thingsID:model.pusId type:RewardAlertType_Skill] showInWindow];
            } else if (index == 4) {//约ta
                AppointmentHerViewController *vc = [[AppointmentHerViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 30)];
        [_searchTF setCorner:CORNER_10];
        _searchTF.backgroundColor = [COLOR_UI_FFFFFF colorWithAlphaComponent:0.5];
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.enablesReturnKeyAutomatically = YES;
        _searchTF.delegate = self;
        _searchTF.font = KFont(14);
        _searchTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MARGIN_10, 0)];
        _searchTF.leftViewMode = UITextFieldViewModeAlways;
        _searchTF.placeholder = @"请输入关键字";
    }
    return _searchTF;
}

@end
