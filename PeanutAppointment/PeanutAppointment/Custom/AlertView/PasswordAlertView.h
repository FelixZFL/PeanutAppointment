//
//  PasswordAlertView.h
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AuthSuccessBlock)(NSString *pwd);

NS_ASSUME_NONNULL_BEGIN

@interface PasswordAlertView : UIView


- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithTitle:(NSString *)titleStr Block:(AuthSuccessBlock )block;

@end

NS_ASSUME_NONNULL_END
