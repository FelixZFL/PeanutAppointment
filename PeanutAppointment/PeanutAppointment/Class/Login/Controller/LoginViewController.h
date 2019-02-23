//
//  LoginViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : BaseViewController

@property (nonatomic, copy) void(^loginSuccessBlock) (void);

@end

NS_ASSUME_NONNULL_END
