//
//  ChangePasswordHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordHeadView : UIView

@property (nonatomic, copy) void(^confirmBlock) (NSString *phone, NSString *code, NSString *password);

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
