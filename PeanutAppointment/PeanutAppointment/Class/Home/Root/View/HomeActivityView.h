//
//  HomeActivityView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeGamesModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeActivityView : UIView

@property (nonatomic, copy) void(^imageTapAction) (NSInteger index, HomeGamesModel *model);

@property (nonatomic, strong) NSArray<HomeGamesModel *> *gamesArray;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
