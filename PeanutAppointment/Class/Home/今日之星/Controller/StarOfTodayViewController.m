//
//  StarOfTodayViewController.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "StarOfTodayViewController.h"

#define kBtnTag 541

@interface StarOfTodayViewController ()

@end

@implementation StarOfTodayViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    UIImageView *imagV = [[UIImageView alloc] init];
    imagV.backgroundColor = COLOR_UI_000000;
    [self.view addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    CGFloat btnHeight = 44;
    CGFloat btnWidht = SCREEN_WIDTH/5.f;
    
    UIView *btnView = [UIView viewWithColor:[COLOR_UI_FFFFFF colorWithAlphaComponent:.5]];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(btnHeight + HOMEBAR_HEIGHT);
    }];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnWidht, 0, btnWidht, btnHeight)];
        [btn setButtonStateNormalTitle:@"" Font:KFont(12) textColor:COLOR_UI_666666];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        if (i == 0) {
            [btn setImage:imageNamed(@"home_btn_share") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"分享"];
        }else if (i == 1) {
            [btn setImage:imageNamed(@"home_btn_comment") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"232"];
        }else if (i == 2) {
            [btn setImage:imageNamed(@"home_btn_like") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"3435"];
        }else if (i == 3) {
            [btn setImage:imageNamed(@"home_btn_reward") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"42534"];
        }else {
            [btn setImage:imageNamed(@"home_btn_appointment") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"约Ta"];
        }
        
    }
    
    
}

- (void)setupNav {
    //[self.customNavBar setTitle:@"今日之星"];
    
    [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_close")];
    [self.view bringSubviewToFront:self.customNavBar];
    [self.customNavBar setBackgroundAlpha:0];
}


#pragma mark - network


#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    NSLog(@"tag----=== %ld",sender.tag - kBtnTag);
}




@end
