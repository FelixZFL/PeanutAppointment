//
//  UIImage+Extension.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

///图片方向调整
- (UIImage *)fixOrientation;

/**
 改变图片大小
 
 @param newSize 目标尺寸
 @return 修改后的图片
 */
-(UIImage *)resizeTo:(CGSize)newSize;

///通过颜色创建一张图片
+ (UIImage*) createImageWithColor:(UIColor*) color;


@end

NS_ASSUME_NONNULL_END
