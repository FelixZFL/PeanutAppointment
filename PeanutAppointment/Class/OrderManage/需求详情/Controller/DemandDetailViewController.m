//
//  DemandDetailViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "DemandDetailViewController.h"
#import "DemandDetailHeadView.h"
#import "DemandDetailCell.h"

@interface DemandDetailViewController ()

@property (nonatomic, strong) DemandDetailHeadView *headView;

@end

@implementation DemandDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
//    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"需求详情"];
    
}

- (void)setupUI {
    
    self.tableView.tableHeaderView = self.headView;
}


#pragma mark - network

- (void)getData {
    
//    [YQNetworking postWithApiNumber:API_NUM_20008 params:@{@"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
//
//        if (getResponseIsSuccess(response)) {
//            [self.dataArr addObjectsFromArray:[MyExceptionalModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
//            [self.tableView reloadData];
//        }
//        self.placeholderView.hidden = self.dataArr.count > 0;
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    } failBlock:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    }];
}

#pragma mark - action


#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;//self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DemandDetailCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [DemandDetailCell reuseIdentifier];
    DemandDetailCell *cell = (DemandDetailCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DemandDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataArr.count > indexPath.row) {
//        [cell setModel:self.dataArr[indexPath.row] index:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter

- (DemandDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[DemandDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [DemandDetailHeadView getHeight])];
    }
    return _headView;
}

@end
