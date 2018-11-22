//
//  BoundPhoneViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BoundPhoneViewController.h"
#import "BoundPhoneHeadView.h"

@interface BoundPhoneViewController ()

@property (nonatomic, strong) BoundPhoneHeadView *headView;

@end

@implementation BoundPhoneViewController

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
    
    self.tableView.tableHeaderView = self.headView;
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"绑定手机号"];
}


#pragma mark - network

#pragma mark - action


#pragma mark - getter

- (BoundPhoneHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[BoundPhoneHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [BoundPhoneHeadView getHeight])];
        [_headView setConfirmBlock:^(NSString * _Nonnull phone, NSString * _Nonnull code) {
            [YQNetworking postWithApiNumber:API_NUM_10013 params:@{@"phone":phone,@"msgCode":code,@"userId":weakSelf.userId} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    if (weakSelf.boundPhoneSuccessBlock) {
                        weakSelf.boundPhoneSuccessBlock(phone);
                    }
                }
            } failBlock:nil];
            
        }];
    }
    return _headView;
}

@end
