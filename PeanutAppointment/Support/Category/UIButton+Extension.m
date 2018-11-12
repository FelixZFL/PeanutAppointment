//
//  UIButton+Extension.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color {
    UIButton *button = [[UIButton alloc] init];
    [button setButtonStateNormalTitle:title Font:font textColor:color];
    return button;
}

- (void)setButtonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = font;
}

- (void)setButtonStateNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setButtonStateNormalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (void)verticalImageAndTitle:(CGFloat)spacing{
    
    
    //    CGSize titleSize = self.titleLabel.frame.size;
    //NSLog(@"=======   %@",self.titleLabel);
    
    CGSize imageSize = self.imageView.image.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    
    //    if(titleSize.width+0.5< frameSize.width) {
    //        titleSize.width= frameSize.width;
    //    }
    
    CGFloat totalHeight = (imageSize.height+ frameSize.height+ spacing);
    
    self.imageEdgeInsets=UIEdgeInsetsMake(- (totalHeight - imageSize.height),0.0,0.0, - frameSize.width);
    
    self.titleEdgeInsets=UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - frameSize.height),0);
}

- (void)horizontalTitleAndImage:(CGFloat)spacing {
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.image.size.width - spacing/2, 0, self.imageView.image.size.width + spacing/2)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + spacing/2, 0, -self.titleLabel.bounds.size.width - spacing/2)];
}

@end
