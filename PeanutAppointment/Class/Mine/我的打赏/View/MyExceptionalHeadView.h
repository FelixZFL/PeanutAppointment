//
//  MyExceptionalHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyExceptionalModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyExceptionalHeadView : UIView

+ (CGFloat )getHeight;

- (void)updateWithModel:(MyExceptionalModel *)model;

@end

NS_ASSUME_NONNULL_END
