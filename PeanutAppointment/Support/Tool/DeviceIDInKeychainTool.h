//
//  DeviceIDInKeychainTool.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceIDInKeychainTool : NSObject


///得到 UUID 后存入系统中的 keychain 的方法
+(NSString *)getDeviceIDInKeychain;


@end

NS_ASSUME_NONNULL_END
