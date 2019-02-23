//
//  HomeStarOfTodayView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeHotUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeStarOfTodayView : UIView

@property (nonatomic, copy) void(^tapActionBlcok) (HomeHotUserModel *model);

@property (nonatomic, strong) NSArray<HomeHotUserModel *> *dataArray;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
