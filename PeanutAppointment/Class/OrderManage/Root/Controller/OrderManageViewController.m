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

#import "OrderManageListModel.h"

#import "MessageListViewController.h"
#import "DemandDetailViewController.h"//需求详情

@interface OrderManageViewController ()

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation OrderManageViewController

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
    self.selectIndex = 0;
    TypeChooseView *headView = [TypeChooseView typeViewWithTypeArr:@[@"需求管理",@"接单中",@"已完成"] withSelectIndex:0 chooseBlock:^(NSInteger selectIndex) {
        self.selectIndex = selectIndex;
        [self.tableView reloadData];
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
    
    [self.customNavBar setRightButtonWithTitle:@"消息" titleColor:COLOR_UI_FFFFFF];
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
    NSString *apiNum = @"";
    if (_selectIndex == 0) {
        apiNum = API_NUM_20026;
    } else if (_selectIndex == 1) {
        apiNum = API_NUM_20027;
    } else {
        apiNum = API_NUM_20028;
    }
    
    [YQNetworking postWithApiNumber:apiNum params:@{@"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            
            [self.dataArr addObjectsFromArray:[OrderManageListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectIndex == 0) {
        return [OrderManageManageCell getCellHeight];
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
        return cell;
    } else {
        NSString *identifier = [OrderManageCell reuseIdentifier];
        OrderManageCell *cell = (OrderManageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OrderManageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setButtonClickBlock:^(NSInteger index) {
                if (index == 0) {
                    
                } else if (index == 1) {//删除订单
                    [YQNetworking postWithApiNumber:API_NUM_10018 params:@{@"userId":[PATool getUserId],@"orderId":@""} successBlock:^(id response) {
                        if (getResponseIsSuccess(response)) {
                            [self.tableView.mj_header beginRefreshing];
                        }
                    } failBlock:nil];
                } else {
                    
                }
            }];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandDetailViewController *vc = [[DemandDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter



@end
