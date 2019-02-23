//
//  MyMainPageViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyMainPageViewController.h"
#import "MyMainPageHeadView.h"

#import "MyMainPageModel.h"

#import "PhotoAlbumViewController.h"

@interface MyMainPageViewController ()

@property (nonatomic, strong) MyMainPageHeadView *headView;

@end

@implementation MyMainPageViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"我的主页"];
}

#pragma mark - network

- (void)getData {
    [YQNetworking postWithApiNumber:API_NUM_20009 params:@{@"userId":[PATool getUserId],@"page":@(0),@"limit":@(10)} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            MyMainPageModel *model = [MyMainPageModel mj_objectWithKeyValues:getResponseData(response)];
            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [MyMainPageHeadView getHeightWithModel:model]);
            [self.headView updateWithModel:model];
            self.tableView.tableHeaderView = self.headView;
        }
    } failBlock:nil];
}


#pragma mark - action

#pragma mark - getter
- (MyMainPageHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[MyMainPageHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        [_headView setPhotoClickBlock:^{
            PhotoAlbumViewController *vc = [[PhotoAlbumViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headView;
}

@end
