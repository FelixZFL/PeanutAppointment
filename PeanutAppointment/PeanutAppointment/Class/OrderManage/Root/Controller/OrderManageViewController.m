//
//  OrderManageViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "OrderManageViewController.h"
#import "TypeChooseView.h"
#import "OrderManageCell.h"
#import "OrderManageManageCell.h"
#import "LocationManager.h"
#import "CommentListAlertView.h"

#import "OrderManageListModel.h"
#import "OrderManageDoneListModel.h"

#import "MessageListViewController.h"
#import "DemandDetailViewController.h"//需求详情

@interface OrderManageViewController ()

@property (nonatomic, strong) CLLocation *location;//当前定位

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation OrderManageViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    self.selectIndex = 0;
    TypeChooseView *headView = [TypeChooseView typeViewWithTypeArr:@[@"需求管理",@"接单中",@"已完成"] withSelectIndex:0 chooseBlock:^(NSInteger selectIndex) {
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
}

- (void)setupNav {
    [self.customNavBar setTitle:@"订单管理"];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.customNavBar setLeftButtonWithTitle:@"担保交易" titleColor:COLOR_UI_FFFFFF];
    [self.customNavBar setOnClickLeftButton:^(UIButton *btn) {
        
    }];
    
    [self.customNavBar setRightButtonWithImage:imageNamed(@"message_read")];
    [self.customNavBar setOnClickRightButton:^(UIButton *btn) {
        MessageListViewController *vc = [[MessageListViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
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
        
        NSString *apiNum = @"";
        if (_selectIndex == 0) {
            apiNum = API_NUM_20026;
        } else if (_selectIndex == 1) {
            apiNum = API_NUM_20027;
        } else {
            apiNum = API_NUM_20028;
        }
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        //lng：（长）经度 lat：（短）纬度
        //[PAUserDefaults saveUserId:@"1fa4535f42ca41329e086f2afd9be2d1"];  [PATool getUserId]
        [YQNetworking postWithApiNumber:apiNum params:@{@"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize),@"lng":@(_location.coordinate.longitude),@"lat":@(_location.coordinate.latitude)} successBlock:^(id response) {
            [SVProgressHUD dismiss];
            if (getResponseIsSuccess(response)) {
                if (self.selectIndex == 0) {
                    [self.dataArr addObjectsFromArray:[OrderManageListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
                } else {
                    [self.dataArr addObjectsFromArray:[OrderManageDoneListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
                }
                [self.tableView reloadData];
            }
            
//            self.placeholderView.hidden = self.dataArr.count > 0;
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } failBlock:^(NSError *error) {
            [SVProgressHUD dismiss];
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
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex == 0) {
        if (self.dataArr.count > indexPath.row) {
            return [OrderManageManageCell getCellHeightWithModel:self.dataArr[indexPath.row]];
        }
        return 200;//0;
    } else {
        return [OrderManageCell getCellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex == 0) {
        NSString *identifier = [OrderManageManageCell reuseIdentifier];
        OrderManageManageCell *cell = (OrderManageManageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderManageManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (self.dataArr.count > indexPath.row) {
            [cell setModel:self.dataArr[indexPath.row]];
        }
        return cell;
    } else {
        NSString *identifier = [OrderManageCell reuseIdentifier];
        OrderManageCell *cell = (OrderManageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setButtonClickBlock:^(UIButton * _Nonnull sender, OrderManageDoneListModel * _Nonnull model) {
                if ([sender.titleLabel.text isEqualToString:@"删除订单"]) {
                    [YQNetworking postWithApiNumber:API_NUM_10018 params:@{@"userId":[PATool getUserId],@"orderId":model.orderId} successBlock:^(id response) {
                        if (getResponseIsSuccess(response)) {
                            [self.tableView.mj_header beginRefreshing];
                        }
                    } failBlock:nil];
                } else if ([sender.titleLabel.text isEqualToString:@"去评价"]) {
                    [[CommentListAlertView alertWithId:model.pasId] showInWindow];
                } else if ([sender.titleLabel.text isEqualToString:@"应邀赚钱"]) {
                    [YQNetworking postWithApiNumber:API_NUM_10019 params:@{@"userId":[PATool getUserId],@"orderId":model.orderId} successBlock:^(id response) {
                        if (getResponseIsSuccess(response)) {
                            [self.tableView.mj_header beginRefreshing];
                        }
                    } failBlock:nil];
                } else if ([sender.titleLabel.text isEqualToString:@"发消息"]) {
                    
                }
                
            }];
        }
        if (self.dataArr.count > indexPath.row) {
            [cell setModel:self.dataArr[indexPath.row] isDone:_selectIndex == 2];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectIndex == 0 && self.dataArr.count > indexPath.row) {
        OrderManageListModel *model = self.dataArr[indexPath.row];
        if (model.invitedList.count > 0) {
            OrderManageInvitedListModel *invitedUser = model.invitedList.firstObject;
            DemandDetailViewController *vc = [[DemandDetailViewController alloc] init];
            vc.orderId = model.poId;
            vc.yUserId = invitedUser.puId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - getter



@end
