//
//  RebateRankingViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RebateRankingViewController.h"
#import "RebateRankingCell.h"

#import "RebateRankingModel.h"

@interface RebateRankingViewController ()

@end

@implementation RebateRankingViewController

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
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"返利排行"];
}

#pragma mark - refresh -

- (void)addRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self getData];
    }];
    
    [self getData];
}

#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20001 params:@{} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[RebateRankingModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.tableView reloadData];
        }
        
        self.placeholderView.hidden = self.dataArr.count > 0;
        
        [self.tableView.mj_header endRefreshing];
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RebateRankingCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [RebateRankingCell reuseIdentifier];
    RebateRankingCell *cell = (RebateRankingCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RebateRankingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row] index:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter

@end
