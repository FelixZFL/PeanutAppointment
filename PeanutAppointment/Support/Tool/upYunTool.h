//
//  upYunTool.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface upYunTool : NSObject

+ (void)upImage:(UIImage *)image successHandle:(void (^) (NSString *url) )success failureHandle:( void (^) (NSError *error) )failure;

@end

NS_ASSUME_NONNULL_END
