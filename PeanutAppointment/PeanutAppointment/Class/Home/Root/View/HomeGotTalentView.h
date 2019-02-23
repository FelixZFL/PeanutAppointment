//
//  HomeGotTalentView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeVideoHotUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeGotTalentView : UIView

@property (nonatomic, copy) void(^tapActionBlcok) (HomeVideoHotUserModel *model);

@property (nonatomic, strong) NSArray<HomeVideoHotUserModel *> *dataArray;

+ (CGFloat )getHeightWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
