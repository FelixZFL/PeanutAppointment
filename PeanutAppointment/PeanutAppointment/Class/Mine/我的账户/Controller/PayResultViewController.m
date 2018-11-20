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
    
    [self setTitle:_isSuccess ? @"支付成功" : @"支付失败"];
    __weak __typeof(self)weakSelf = self;
    [self.customNavBar setOnClickLeftButton:^(UIButton *btn) {
        [weakSelf back];
    }];
}

- (void)setupUI {
    
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = COLOR_UI_FFFFFF;
    
    UILabel *moneyLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
    if (_isSuccess) {
        NSString *payString = [NSString stringWithFormat:@"您已经成功支付%@元",_money];
        [moneyLabel setTextString:payString AndColorSubString:_money color:COLOR_UI_THEME_RED];
    } else {
        [moneyLabel setText:@"支付失败"];
    }
    [headView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(MARGIN_15);
    }];
    self.tableView.tableHeaderView = headView;
}

- (void)back {
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    if (index>2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}


@end
