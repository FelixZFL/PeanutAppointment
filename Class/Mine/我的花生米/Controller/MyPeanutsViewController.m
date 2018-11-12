//
//  MyPeanutsViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyPeanutsViewController.h"
#import "MyPeanutsHeadView.h"
#import "MyPeanutsSingleCell.h"

#import "MyPeanutsListModel.h"

@interface MyPeanutsViewController ()

@property (nonatomic, strong) MyPeanutsHeadView *headView;

@end

@implementation MyPeanutsViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"我的花生米"];
    
}

- (void)setupUI {
    
    CGFloat headViewHeight = [MyPeanutsHeadView getHeight];
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NAVITETION_HEIGHT);
        make.height.mas_equalTo(headViewHeight);
    }];
    
    CGFloat top = headViewHeight + NAVITETION_HEIGHT;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
    }];
    
    [self.view bringSubviewToFront:self.placeholderView];
    [self.placeholderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
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
    
    //page=1&limit=20
    [YQNetworking postWithApiNumber:API_NUM_20002 params:@{@"phone":[PAUserDefaults getUserBoundPhone], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            MyPeanutsListModel *model = [MyPeanutsListModel mj_objectWithKeyValues:getResponseData(response)];
            [self.headView updateWithModel:model];
            [self.dataArr addObjectsFromArray:model.fansList];
            [self.tableView reloadData];
        }
        
        self.placeholderView.hidden = self.dataArr.count > 0;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - action


#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyPeanutsSingleCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = [MyPeanutsSingleCell reuseIdentifier];
    MyPeanutsSingleCell *cell = (MyPeanutsSingleCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyPeanutsSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter

- (MyPeanutsHeadView *)headView {
    if (!_headView) {
        _headView = [[MyPeanutsHeadView alloc] init];
    }
    return _headView;
}


@end
