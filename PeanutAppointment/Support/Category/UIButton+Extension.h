//
//  UIButton+Extension.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (UIButton *)buttonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color;
- (void)setButtonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color;

- (void)setButtonStateNormalTitle:(NSString *)title;
- (void)setButtonStateNormalImage:(UIImage *)image;

- (void)verticalImageAndTitle:(CGFloat)spacing;

- (void)horizontalTitleAndImage:(CGFloat)spacing;

@end
