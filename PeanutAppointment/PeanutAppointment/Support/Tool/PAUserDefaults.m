//
//  PAUserDefaults.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PAUserDefaults.h"

//设备id
#define KEY_USER_TOKEN @"KEY_USER_TOKEN"

//用户id
#define KEY_USERID @"KEY_USERID"
//用户绑定手机号
#define KEY_USER_BOUND_PHONE @"KEY_USER_BOUND_PHONE"

//版本号
#define KEY_SHORT_VERSION @"KEY_SHORT_VERSION"

//设备id
#define KEY_DEVICE_TOKEN @"KEY_DEVICE_TOKEN"

//app重新加载
#define KEY_APP_RESETED @"KEY_APP_RESETED"

@implementation PAUserDefaults

+ (void)saveObject:(id)obj forKey:(NSString *)key {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:obj forKey:key];
    [def synchronize];
}

+ (id)getObjectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


//MARK:// 设备 token
+ (void) saveDeviceToken:(NSString*) deviceToken
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:deviceToken forKey:KEY_DEVICE_TOKEN];
    [def synchronize];
}

+ (NSString *) getDeviceToken
{
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_DEVICE_TOKEN];
    if(token == nil || token.length == 0)
    {
        return @"";
    } else
    {
        return token;
    }
}


+(void)saveUserId:(NSString *)userId{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:userId forKey:KEY_USERID];
    [def synchronize];
}
+(NSString *)getUserId{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def stringForKey:KEY_USERID];
}

+ (void) saveUserBoundPhone:(NSString*) userId {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:userId forKey:KEY_USER_BOUND_PHONE];
    [def synchronize];
}
+ (NSString *) getUserBoundPhone {
    NSString *phone = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USER_BOUND_PHONE];
    if(phone == nil || phone.length == 0)
    {
        return @"";
    } else
    {
        return phone;
    }
}


//MARK: token
+ (void) saveUserToken:(NSString*)userToken
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:userToken forKey:KEY_USER_TOKEN];
    [def synchronize];
}

+ (NSString *) getUserToken
{
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_USER_TOKEN];
    if(token == nil || token.length == 0)
    {
        return @"";
    } else
    {
        return token;
    }
}


//MARK:保存已看过新特性的版本号
+ (void)saveVersionOfNewFeature:(NSString *)version {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:version forKey:KEY_SHORT_VERSION];
    [def synchronize];
}

+ (NSString *)getVersionOfNewFeature {
    NSString *version = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_SHORT_VERSION];
    if(version == nil || version.length == 0)
    {
        return @"0";
    } else
    {
        return version;
    }
}


///保存app是否重新启动过
+ (void) saveAppReseted:(BOOL) isReseted {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:isReseted forKey:KEY_APP_RESETED];
    [def synchronize];
}

+ (BOOL) getAppReseted {
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_APP_RESETED];
}



//退出登录
+ (void) logout
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:KEY_USERID];
    [def removeObjectForKey:KEY_USER_BOUND_PHONE];
    [def synchronize];
}

@end
