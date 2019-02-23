//
//  PATool.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PATool.h"
#import "DeviceIDInKeychainTool.h"
#import "RSAEncryptor.h"

@implementation PATool

///是否登录
+ (BOOL)isLogin {
    
    NSString *userId = [PAUserDefaults getUserId];
    if (!userId || [userId length] == 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)getUserId {
    if ([self isLogin]) {
        return [PAUserDefaults getUserId];
    }else {
        return @"";
    }
}

//时间转换格式
+ (NSString *)getTimeStringWithTime:(NSString *)fromTime
                      fromFormatter:(NSString *)fromFormat
                        toFormatter:(NSString *)toformat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromFormat];
    NSDate *date = [formatter dateFromString:fromTime];
    
    NSString *time = @"";
    [formatter setDateFormat:toformat];
    time = [formatter stringFromDate:date];
    
    return time;
}


+ (NSString *)getFullURLByNum:(NSString *)num {
    if ([num integerValue] > 20000) {
        return [NSString stringWithFormat:@"%@%@",BaseURL,APITypeQuery];
    }else {
        return [NSString stringWithFormat:@"%@%@",BaseURL,APITypeWrite];
    }
}


+ (NSMutableDictionary *)addKeyAndNum:(NSString *)num toParams:(NSDictionary *)params {
    
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
    //把num添加到字典
    [mDic setObject:num forKey:@"num"];
    [mDic setObject:@"1" forKey:@"key"];
    
    //判断值为空字符串的就不传
    for (NSString *key in [mDic allKeys]) {
        NSString *value = [NSString stringWithFormat:@"%@",[params objectForKey:key]];
        if ([value length] == 0) {
            [mDic removeObjectForKey:key];
        }
    }
    
//    if ([[PATool getUserId] length] > 0) {
//        [mDic setObject:[PATool getUserId] forKey:@"duserId"];
//    }
    //    NSLog(@"deviceid=== %@",[XBTool getDeviceIDInKeychain]);
//    [mDic setObject:[DeviceIDInKeychainTool getDeviceIDInKeychain] forKey:@"deviceId"];
    
//    NSMutableDictionary *returnDic = [NSMutableDictionary dictionaryWithDictionary:@{@"key":[self getRSAKeyWithParams:mDic]}];
    
    return mDic;
}

+ (NSString *)getRSAKeyWithParams:(NSDictionary *)params {
    NSString *string = @"";
    
    for (NSString *key in [params allKeys]) {
        
        NSString *value = [NSString stringWithFormat:@"%@",[params objectForKey:key]];
        
        if ([value length] > 0) {//判断值为空字符串的就不传
            
            NSString *strKeyValue = [NSString stringWithFormat:@"%@`%@^",key,value];
            
            string = [string stringByAppendingString:strKeyValue];
        }
        
    }
    
    string =  [string substringToIndex:string.length - 1];
    
    string = [RSAEncryptor encryptString:string publicKey:RSAPublicKey];
    
    return string;
}

//图片压缩
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}


@end
