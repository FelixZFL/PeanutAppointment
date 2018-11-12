//
//  PayResultViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()

@end

@implementation PayResultViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"支付成功"];
    
}

- (void)setupUI {
    
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = COLOR_UI_FFFFFF;
    
    UILabel *moneyLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
    [moneyLabel setTextString:@"您已经成功支付￥300.00元" AndColorSubString:@"￥300.00" color:COLOR_UI_THEME_RED];
    [headView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(MARGIN_15);
    }];
    self.tableView.tableHeaderView = headView;
}

@end
