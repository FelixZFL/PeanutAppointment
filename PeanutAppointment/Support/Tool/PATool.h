//
//  PATool.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PATool : NSObject

///是否登录
+ (BOOL)isLogin;

///获取用户id
+ (NSString *)getUserId;

/////获取用户token
//+ (NSString *)getUserRecommandCode;

/**
 时间格式转换
 
 @param fromTime 需要转换格式的时间
 @param fromFormat 转换前的时间格式
 @param toformat 转换后的时间格式
 @return 转换好格式的时间
 */
+ (NSString *)getTimeStringWithTime:(NSString *)fromTime
                      fromFormatter:(NSString *)fromFormat
                        toFormatter:(NSString *)toformat;



+ (NSString *)getFullURLByNum:(NSString *)num;

+ (NSMutableDictionary *)addKeyAndNum:(NSString *)num toParams:(NSDictionary *)params;

/**
 * 压缩图片到指定文件大小
 *
 * @param image 目标图片
 * @param size 目标大小（最大值）
 *
 * @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end
