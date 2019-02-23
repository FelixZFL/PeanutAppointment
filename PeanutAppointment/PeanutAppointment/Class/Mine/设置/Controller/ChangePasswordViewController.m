//
//  ChangePasswordViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordHeadView.h"

@interface ChangePasswordViewController ()

@property (nonatomic, strong) ChangePasswordHeadView *headView;

@end

@implementation ChangePasswordViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}


#pragma mark - UI

- (void)setupUI {
    
    self.tableView.tableHeaderView = self.headView;
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedAction:)]];

}

- (void)setupNav {
    [self.customNavBar setTitle:@"设置提现密码"];
}


#pragma mark - network

- (void)submitInfoWithParam:(NSDictionary *)param {
    [YQNetworking postWithApiNumber:API_NUM_10002 params:param successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [SVProgressHUD showSuccessWithStatus:@"设置提现密码成功"];
            if (self.submitSuccessBlock) {
                self.submitSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failBlock:nil];
}

#pragma mark - action

#pragma mark - private -
- (void)tapGesturedAction:(UIGestureRecognizer *)gesture {
    
    [self.view endEditing:YES];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - getter

- (ChangePasswordHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[ChangePasswordHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ChangePasswordHeadView getHeight])];
        [_headView setConfirmBlock:^(NSString * _Nonnull phone, NSString * _Nonnull code, NSString * _Nonnull password) {
            [weakSelf submitInfoWithParam:@{@"userId":[PATool getUserId],@"password":password,@"phone":phone,@"msg":code}];
        }];
    }
    return _headView;
}

@end
