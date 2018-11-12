//
//  MyAccountHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyAccountInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyAccountHeadView : UIView

+ (CGFloat )getHeight;

- (void)updateWithModel:(MyAccountInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
