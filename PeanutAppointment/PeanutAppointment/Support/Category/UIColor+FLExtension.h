//
//  UIColor+FLExtension.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FLExtension)


/**
 获取颜色（通过十六进制）

 @param color 十六进制颜色值
 @return 颜色
 */
+ (UIColor *)fl_colorWithHexString:(NSString *)color;

/**
 获取颜色（通过十六进制）

 @param color 十六进制颜色值
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)fl_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
