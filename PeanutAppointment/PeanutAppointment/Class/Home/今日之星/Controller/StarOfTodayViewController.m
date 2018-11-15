//
//  StarOfTodayViewController.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "StarOfTodayViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HomeIndexUserModel.h"
#import "ShareDataModel.h"
#import "AlertShareView.h"
#import "CommentListAlertView.h"
#import "RewardAlertView.h"

#import "AppointmentHerViewController.h"

#define kBtnTag 541

@interface StarOfTodayViewController ()<SDCycleScrollViewDelegate>

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
    
    SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] init];
    bannerView.delegate  = self;
    bannerView.autoScroll = NO;
    bannerView.currentPageDotColor = COLOR_UI_THEME_RED;
    bannerView.pageDotColor = COLOR_UI_FFFFFF;
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFill
    bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    NSArray *arr = [_model.photos componentsSeparatedByString:@","];
    bannerView.imageURLStringsGroup = arr;
    if (arr.count > _selectIndex) {
        [bannerView makeScrollViewScrollToIndex:_selectIndex];
    }
    
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
            [btn setButtonStateNormalTitle:_model.commentNumber];
        }else if (i == 2) {
            [btn setImage:imageNamed(@"home_btn_like") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:_model.likeNumber];
        }else if (i == 3) {
            [btn setImage:imageNamed(@"home_btn_reward") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:_model.goldNumber];
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
    NSInteger index = sender.tag - kBtnTag;
    if (_model) {
        if (index == 0) {//分享
            [YQNetworking postWithApiNumber:API_NUM_10023 params:@{@"userId":_model.userId, @"pusId":_model.pusId} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    ShareDataModel *model =[ShareDataModel mj_objectWithKeyValues:getResponseData(response)];
                    [[AlertShareView alertWithModel:model] showInWindow];
                }
            } failBlock:nil];
        } else if (index == 1) {//评论
            [[CommentListAlertView alertWithId:_model.pusId] showInWindow];
            
        } else if (index == 2) {//点赞
            [YQNetworking postWithApiNumber:API_NUM_10015 params:@{@"userId":[PATool getUserId],@"pusId":_model.pusId} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    [sender setButtonStateNormalTitle:[NSString stringWithFormat:@"%ld",[sender.titleLabel.text integerValue] + 1]];
                }
            } failBlock:nil];
        } else if (index == 3) {//打赏
            [[RewardAlertView alertWithUserId:_model.userId thingsID:_model.pusId type:RewardAlertType_Skill] showInWindow];
        } else if (index == 4) {//约ta
            AppointmentHerViewController *vc = [[AppointmentHerViewController alloc] init];
            vc.choosedUser = _model;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}

#pragma mark - SDCycleScrollViewDelegate -
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    //    NSLog(@"图片滚动回调");
}



@end
