//
//  TitleImageButton.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleImageButton : UIControl

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;


+ (instancetype) buttonWithTitle:(NSString *)title;

+ (instancetype) buttonWithTitle:(NSString *)title Font:(UIFont *)font titleColor:(UIColor *)color image:(UIImage *)image;


- (void)setButtonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color;

- (void)setTitle:(NSString *)title Image:(UIImage *)image;

- (void)setTitle:(NSString *)title;

@end
