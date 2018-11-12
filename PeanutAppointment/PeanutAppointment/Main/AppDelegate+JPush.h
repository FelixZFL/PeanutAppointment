//
//  AppDelegate+JPush.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AppDelegate.h"

//#import <JPush/JPUSHService.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate (JPush)<JPUSHRegisterDelegate>


- (void)setStartJPUSHServiceWithOptions:(NSDictionary *)launchOptions;

//注册APNs成功并上报DeviceToken
- (void)JPapplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
//实现注册APNs失败接口
- (void)JPapplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;


#pragma mark ----------------前后台通知------------------------
- (void)JPapplicationDidEnterBackground:(UIApplication *)application;

- (void)JPapplicationWillEnterForeground:(UIApplication *)application;



@end

