//
//  MineHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MineHeadView : UIView

+ (CGFloat )getHeight;

- (void)updateWithModel:(UserInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
