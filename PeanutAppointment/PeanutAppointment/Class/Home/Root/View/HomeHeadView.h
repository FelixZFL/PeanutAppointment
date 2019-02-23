//
//  HomeHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeActivityView.h"
#import "HomeStarOfTodayView.h"
#import "HomeGotTalentView.h"
#import "HomeSkillBtnModel.h"

@class HomeModel;
@class HomeBannerModel;

#define HomeHannerHeight (SCREEN_WIDTH * 188/375.f)

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeadView : UIView

@property (nonatomic, copy) void(^headButtonBlock) (HomeSkillBtnModel *model);
@property (nonatomic, copy) void(^bannerClickBlock) (HomeBannerModel *model);

@property (nonatomic, strong) HomeActivityView *activityView;//活动
@property (nonatomic, strong) HomeStarOfTodayView *starView;//今日之星
@property (nonatomic, strong) HomeGotTalentView *talentView;//今日达人

+ (CGFloat )getHeightWithModel:(nullable HomeModel *)model;

- (void)updateWithModel:(HomeModel *)model;

@end

NS_ASSUME_NONNULL_END
