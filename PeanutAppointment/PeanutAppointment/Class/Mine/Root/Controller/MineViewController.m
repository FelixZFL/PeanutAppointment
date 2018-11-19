//
//  MineViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "MineCell.h"

#import "MineModel.h"
#import "UserInfoModel.h"

#import "MyInfoViewController.h"//个人信息
#import "ShareViewController.h"//分享赚钱
#import "RebateRankingViewController.h"//返利排行
#import "MyPeanutsViewController.h"//我的花生米
#import "BuyVIPViewController.h"//购买会员
#import "MyAccountViewController.h"//我的账户
#import "IntegralExchangeViewController.h"//积分兑换
#import "MyExceptionalViewController.h"//我的打赏
#import "MyMainPageViewController.h"//我的主页
#import "PhotoAlbumViewController.h"//相册
#import "PersonalAuthViewController.h"//个人认证
#import "H5ViewController.h"// H5  关于
#import "SettingViewController.h"//设置




@interface MineViewController ()

@property (nonatomic, strong) MineHeadView *headView;
@property (nonatomic, strong) UserInfoModel *model;

@end

@implementation MineViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    NSArray *array = @[
                       @[@{@"icon":@"mine_icon_share",@"text":@"分享赚钱",@"controller":@"ShareViewController"},
                         @{@"icon":@"mine_icon_ rebate",@"text":@"返利排行",@"controller":@"RebateRankingViewController"},
                         @{@"icon":@"mine_icon_myPeanut",@"text":@"我的花生米",@"controller":@"MyPeanutsViewController"}
                         ],
                       @[@{@"icon":@"mine_icon_vip",@"text":@"会员",@"controller":@"BuyVIPViewController"},
                         @{@"icon":@"mine_icon_account",@"text":@"账户",@"controller":@"MyAccountViewController"},
                         @{@"icon":@"mine_icon_integral",@"text":@"积分兑换",@"controller":@"IntegralExchangeViewController"}
                         ],
                       @[@{@"icon":@"mine_icon_myReward",@"text":@"我的打赏",@"controller":@"MyExceptionalViewController"},
                         @{@"icon":@"mine_icon_myPage",@"text":@"个人主页",@"controller":@"MyMainPageViewController"},
                         @{@"icon":@"mine_icon_myPhotos",@"text":@"我的相册",@"controller":@"PhotoAlbumViewController"},
                         @{@"icon":@"mine_icon_auth",@"text":@"个人认证",@"controller":@"PersonalAuthViewController"},
                         ],
                       @[@{@"icon":@"mine_icon_about",@"text":@"关于APP及规则",@"controller":@"H5ViewController"},
                         @{@"icon":@"mine_icon_setting",@"text":@"设置",@"controller":@"SettingViewController"}
                         ],
                       ];
    self.dataArr = [NSMutableArray arrayWithArray:[MineModel mj_objectArrayWithKeyValuesArray:array]];
    
    
    self.tableView.tableHeaderView = self.headView;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TABBAR_HEIGHT);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"个人中心"];
}

#pragma mark - network

- (void)getData {
    [YQNetworking postWithApiNumber:API_NUM_20007 params:@{@"userId":[PATool getUserId]} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:getResponseData(response)];
            self.model = model;
            [self.headView updateWithModel:model];
        }
    } failBlock:nil];
}


#pragma mark - action

- (void)userInfoTapAction {
    if (self.model) {
        MyInfoViewController *vc = [[MyInfoViewController alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return MARGIN_10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = COLOR_UI_F0F0F0;
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArr[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MineCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [MineCell reuseIdentifier];
    MineCell *cell = (MineCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *array = self.dataArr[indexPath.section];
    cell.model = array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.dataArr[indexPath.section];
    MineModel *model = array[indexPath.row];

    if (model.controller.length > 0) {
        UIViewController *vc = [[NSClassFromString(model.controller) alloc] init];
        if ([model.controller isEqualToString:@"H5ViewController"]) {
            H5ViewController * h5vc = (H5ViewController *)vc;
            [YQNetworking postWithApiNumber:API_NUM_20012 params:@{} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    NSDictionary *dic = getResponseData(response);
                    h5vc.jump_URL = dic[@"url"];
                    [self.navigationController pushViewController:h5vc animated:YES];
                }
            } failBlock:nil];

        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark - getter

- (MineHeadView *)headView {
    if (!_headView) {
        _headView = [[MineHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [MineHeadView getHeight])];
        [_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoTapAction)]];
    }
    return _headView;
}

@end
