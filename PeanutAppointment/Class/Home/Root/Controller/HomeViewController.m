//
//  HomeViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "HomeSectionHeadView.h"
#import "HomeCell.h"
#import "XMPPManager.h"
#import "AlertShareView.h"
#import "SignInAlertView.h"
#import "PasswordAlertView.h"
#import "RewardAlertView.h"
#import "RechargeAlertView.h"
#import "CommentListAlertView.h"
#import "LocationManager.h"

#import "HomeModel.h"
#import "ShareDataModel.h"

#import "LoginViewController.h"//登录
#import "MaJiangViewController.h"//麻将
#import "GotTalentOfTodayViewController.h"//今日达人
#import "StarOfTodayViewController.h"//今日之星
#import "SearchViewController.h"//搜索
#import "UserMainPageViewController.h"//ta的主页
#import "AppointmentOrderViewController.h"//选择分类
#import "MessageListViewController.h"//消息
#import "H5ViewController.h"//网页
#import "AppointmentHerViewController.h"//约ta

@interface HomeViewController ()

@property (nonatomic, strong) CLLocation *location;//当前定位

@property (nonatomic, strong) HomeHeadView *headView;
@property (nonatomic, strong) UIImageView *redPackageImageV;//红包

@property (nonatomic, strong) HomeModel *model;

@property (nonatomic, assign) BOOL isShowSign;//是否显示过签到弹出

@end

@implementation HomeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
    
    [self addRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getData];
    if (_isShowSign) {
        _isShowSign = YES;
        //签到
        [[SignInAlertView alertWithBlock:^{
            [YQNetworking postWithApiNumber:API_NUM_10024 params:@{@"userId":[PATool getUserId]} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    //"sign":1 //1：已签到过了 2:签到成功
                    NSDictionary *dic = getResponseData(response);
                    if ([dic[@"sign"] integerValue] == 1) {
                        [SVProgressHUD showInfoWithStatus:@"已签到过了"];
                    } else if ([dic[@"sign"] integerValue] == 2) {
                         [SVProgressHUD showSuccessWithStatus:@"签到成功"];
                    }
                }
            } failBlock:nil];
        }] showInWindow];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    //self.tableView.tableHeaderView = self.headView;
    
    [self.view addSubview:self.redPackageImageV];
    [self.redPackageImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 122));
        make.top.mas_equalTo(HomeHannerHeight + 82*2 - 30);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-TABBAR_HEIGHT);
    }];
    
}

- (void)setupNav {
    
    [self.view bringSubviewToFront:self.customNavBar];
    [self.customNavBar setBackgroundAlpha:0];
    [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_search")];
    __weak __typeof(self)weakSelf = self;
    [self.customNavBar setOnClickLeftButton:^(UIButton *btn) {
        if (![weakSelf cheakLogin]) return;
        SearchViewController *vc = [[SearchViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self.customNavBar setRightButtonWithImage:imageNamed(@"message_read")];
    [self.customNavBar setOnClickRightButton:^(UIButton *btn) {
        if (![weakSelf cheakLogin]) return;
        MessageListViewController *vc = [[MessageListViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)updateUI {
    if (!self.model) {
        return;
    }
    self.redPackageImageV.hidden = NO;
    [self.headView updateWithModel:self.model];
    self.headView.frame = CGRectMake(0, 0, ScreenWidth, [HomeHeadView getHeightWithModel:self.model]);
    self.tableView.tableHeaderView = self.headView;
    [self.tableView reloadData];
    [self cheackHomeAlert];
}


- (void)cheackHomeAlert {
    if ([PAUserDefaults getAppReseted]) {
        [PAUserDefaults saveAppReseted:NO];
        
        if (self.model && self.model.tools) {
//            //弹框
//            [[HomeAnimationAlertView alertWithModel:self.homeModel.tools picClick:^{
//
//                if ([self.homeModel.tools.PICTURE_TYPE integerValue] == 1) {
//                    //商品
//                    CommodityDetailViewController *vc = [[CommodityDetailViewController alloc] init];
//                    vc.goodsId = self.homeModel.tools.PICTURE_ADDR;
//                    [self.navigationController pushViewController:vc animated:YES];
//                }else if ([self.homeModel.tools.PICTURE_TYPE integerValue] == 2) {
//                    //H5
//                    ScanSuccessViewController *vc = [[ScanSuccessViewController alloc] init];
//                    vc.jump_URL = self.homeModel.tools.PICTURE_ADDR;
//                    [self.navigationController pushViewController:vc animated:YES];
//                }else if ([self.homeModel.tools.PICTURE_TYPE integerValue] == 3) {
//                    //店铺
//                    StoreMainViewController *vc = [[StoreMainViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
//                    vc.storeId = self.homeModel.tools.PICTURE_ADDR;
//                }
//            }] showInWindow];
        }
    }
}

#pragma mark - refresh -

- (void)addRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self getData];
}

#pragma mark - network

- (void)getData {
    if (_location) {
        [YQNetworking postWithApiNumber:API_NUM_20017 params:@{@"userId":[PATool getUserId],@"lng":@(_location.coordinate.longitude),@"lat":@(_location.coordinate.latitude)} successBlock:^(id response) {
            [self.tableView.mj_header endRefreshing];
            if (getResponseIsSuccess(response)) {
                self.model  = [HomeModel mj_objectWithKeyValues:getResponseData(response)];
                [self updateUI];
            }
        } failBlock:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
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
//检查是否登录 没有登录跳转到登录
- (BOOL)cheakLogin {
    if ([PATool isLogin]) {
        return YES;
    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
}

#pragma mark - action

- (void)redPackageClickAction:(UITapGestureRecognizer *)tapGes {
    if (![self cheakLogin]) return;
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > HomeHannerHeight - NAVITETION_HEIGHT) {
        [self.customNavBar setBackgroundAlpha:1];
        [self.customNavBar setTitle:@"花生约见"];
    } else {
        [self.customNavBar setBackgroundAlpha:0];
        [self.customNavBar setTitle:@""];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [HomeSectionHeadView getHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *identifier = [HomeSectionHeadView reuseIdentifier];
    HomeSectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(!sectionHeadView){
        sectionHeadView = [[HomeSectionHeadView alloc] initWithReuseIdentifier:identifier];
    }
    return sectionHeadView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.indexUser.count;
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
            if (![self cheakLogin]) return;
            UserMainPageViewController *vc = [[UserMainPageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setImageClickBlock:^(NSInteger index, HomeIndexUserModel * _Nonnull model) {
            if (![self cheakLogin]) return;
            StarOfTodayViewController *vc = [[StarOfTodayViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell setBtnClickBlock:^(NSInteger index, HomeIndexUserModel * _Nonnull model, UIButton *btn) {
            if (![self cheakLogin]) return;
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
    if (self.model.indexUser.count > indexPath.row) {
        [cell setModel:self.model.indexUser[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - getter

- (HomeHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HomeHeadView getHeightWithModel:nil])];
        [_headView setHeadButtonBlock:^(HomeSkillBtnModel * _Nonnull model) {
            if (![weakSelf cheakLogin]) return;
            //
            if (model.pasId.length > 0) {
                SearchViewController *vc = [[SearchViewController alloc] init];
                vc.pasId = model.pasId;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                AppointmentOrderViewController *vc = [[AppointmentOrderViewController alloc] init];
                vc.type = AppointmentOrderViewControllerType_ChooseType;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
        [_headView.activityView setImageTapAction:^(NSInteger index, HomeGamesModel * _Nonnull model) {
            if (![weakSelf cheakLogin]) return;
            if ([model.pType integerValue] == 1) {
                if ([model.clickUrl hasPrefix:@"http"]) {
                    H5ViewController *vc = [[H5ViewController alloc] init];
                    vc.jump_URL = model.clickUrl;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            } else if ([model.pType integerValue] == 2) {
                MaJiangViewController *vc = [[MaJiangViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }];
        [_headView.starView setTapActionBlcok:^(HomeHotUserModel * _Nonnull model) {
            UserMainPageViewController *vc = [[UserMainPageViewController alloc] init];
            vc.userId = model.userId;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        [_headView.talentView setTapActionBlcok:^(HomeVideoHotUserModel * _Nonnull model) {
            GotTalentOfTodayViewController *vc = [[GotTalentOfTodayViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headView;
}

- (UIImageView *)redPackageImageV {
    if (!_redPackageImageV) {
        _redPackageImageV = [[UIImageView alloc] init];
        _redPackageImageV.image = imageNamed(@"home_redPackage");
        _redPackageImageV.userInteractionEnabled = YES;
        _redPackageImageV.hidden = YES;
        [_redPackageImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redPackageClickAction:)]];
    }
    return _redPackageImageV;
}

@end


/*
 NSLog(@"index == %ld",(long)index);
 if (index == 1) {
 UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"登录" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
 [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
 [sheet addAction:[UIAlertAction actionWithTitle:@"haha" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 
 [[XMPPManager shareManager] loginWithName:@"haha" loginBlock:^(BOOL isSucess) {
 NSLog(@"login");
 }];
 
 }]];
 [sheet addAction:[UIAlertAction actionWithTitle:@"felix" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 [[XMPPManager shareManager] loginWithName:@"felix" loginBlock:^(BOOL isSucess) {
 NSLog(@"login");
 }];
 
 }]];
 dispatch_async(dispatch_get_main_queue(), ^{
 [weakSelf presentViewController:sheet animated:YES completion:nil];
 });
 
 } else if (index == 2) {
 [[XMPPManager shareManager] logOut];
 } else if (index == 3) {
 UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
 [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
 [sheet addAction:[UIAlertAction actionWithTitle:@"haha" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 [[XMPPManager shareManager] XMPPAddFriendSubscribe:@"haha"];
 }]];
 [sheet addAction:[UIAlertAction actionWithTitle:@"felix" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 [[XMPPManager shareManager] XMPPAddFriendSubscribe:@"felix"];
 }]];
 dispatch_async(dispatch_get_main_queue(), ^{
 [weakSelf presentViewController:sheet animated:YES completion:nil];
 });
 
 } else if (index == 4) {
 
 NSMutableArray *contacts = [NSMutableArray arrayWithArray:[XMPPManager shareManager].xmppRosterMemoryStorage.unsortedUsers];
 if (contacts.count > 0) {
 XMPPUserMemoryStorageObject *obj = contacts.firstObject;
 
 UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"发消息给" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
 [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
 [sheet addAction:[UIAlertAction actionWithTitle:obj.jid.user style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 [[XMPPManager shareManager] sendMessage:@"消息来了xxxxxx" to:obj.jid];
 }]];
 dispatch_async(dispatch_get_main_queue(), ^{
 [weakSelf presentViewController:sheet animated:YES completion:nil];
 });
 } else if (index == 7) {
 [[PasswordAlertView alertWithBlock:^{
 [SVProgressHUD showInfoWithStatus:@"确定"];
 }] showInWindow];
 }

 */
