//
//  RechargeAlertView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RechargeAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alert;

@end

NS_ASSUME_NONNULL_END