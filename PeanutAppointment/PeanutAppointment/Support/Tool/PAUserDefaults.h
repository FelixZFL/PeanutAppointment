//
//  PAUserDefaults.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define KEY_USER_LOGIN_INFO @"KEY_USER_LOGIN_INFO"

@interface PAUserDefaults : NSObject

+ (void)saveObject:(id)obj forKey:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;


/// 设备 token
+ (void) saveDeviceToken:(NSString*) deviceToken;
+ (NSString *) getDeviceToken;


+ (void) saveUserId:(NSString*) userId;
+ (NSString *) getUserId;

+ (void) saveUserBoundPhone:(NSString*) userId;
+ (NSString *) getUserBoundPhone;


//保存已看过新特性的版本号
+ (void)saveVersionOfNewFeature:(NSString *)version;
//获取已看过新特性的版本号
+ (NSString *)getVersionOfNewFeature;



///保存app是否重新启动过
+ (void) saveAppReseted:(BOOL) isReseted;
///获取app是否重新启动过
+ (BOOL) getAppReseted;


//退出登录
+ (void) logout;

@end
