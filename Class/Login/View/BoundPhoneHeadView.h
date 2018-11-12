//
//  BoundPhoneHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoundPhoneHeadView : UIView

@property (nonatomic, copy) void(^confirmBlock) (NSString *phone, NSString *code);

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
