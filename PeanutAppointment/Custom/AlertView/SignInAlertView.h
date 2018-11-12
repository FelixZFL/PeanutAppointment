//
//  SignInAlertView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/13.
//  Copyright © 2018年 felix. All rights reserved.
//
///签到弹出框


#import <UIKit/UIKit.h>

typedef void(^SignInAlertBtnBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SignInAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithBlock:(SignInAlertBtnBlock )block;

@end

NS_ASSUME_NONNULL_END
