//
//  MyExceptionalViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyExceptionalViewController.h"
#import "MyExceptionalHeadView.h"
#import "MyExceptionalCell.h"

#import "MyExceptionalModel.h"


@interface MyExceptionalViewController ()

@property (nonatomic, strong) MyExceptionalHeadView *headView;

@end

@implementation MyExceptionalViewController

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
    
    [self setTitle:@"我的打赏"];
    
}

- (void)setupUI {
    
    CGFloat headViewHeight = [MyExceptionalHeadView getHeight];
    
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
    
    [YQNetworking postWithApiNumber:API_NUM_20008 params:@{@"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            MyExceptionalModel *model = [MyExceptionalModel mj_objectWithKeyValues:getResponseData(response)];
            [self.headView updateWithModel:model];
            [self.dataArr addObjectsFromArray:model.list];
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
    return [MyExceptionalCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [MyExceptionalCell reuseIdentifier];
    MyExceptionalCell *cell = (MyExceptionalCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyExceptionalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row] index:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter

- (MyExceptionalHeadView *)headView {
    if (!_headView) {
        _headView = [[MyExceptionalHeadView alloc] init];
    }
    return _headView;
}


@end
