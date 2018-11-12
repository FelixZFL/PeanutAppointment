//
//  UILabel+Extension.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)


+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment;
- (void)setLabelFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment;

//设置行间距
-(void)setLineParagrp:(CGFloat)lineSpace;

/**
 设置颜色
 
 @param loc 起始位置
 @param len 设置长度
 @param color 颜色
 */
- (void)setColorWithLoc:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color;

-(void)setColorWithLoc:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color space:(CGFloat)space;

/**
 设置颜色和下划线
 
 @param loc 起始位置
 @param len 设置长度
 @param color 颜色
 */
- (void)setColorAndLineWith:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color;
/**
 设置字体
 
 @param loc 起始位置
 @param len 设置长度
 @param font 字体大小
 */
- (void)setFontWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font;

/**
 设置字体
 
 @param loc 起始位置
 @param len 设置长度
 @param font 字体大小
 @param space 行间距
 */
-(void)setFontWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font space:(CGFloat)space;


/**
 设置字体大小和颜色
 
 @param loc 起始位置
 @param len 设置长度
 @param font 字体大小
 @param color 颜色
 @param space  行间距
 
 */
- (void)setFontAndColorWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font color:(UIColor *)color space:(CGFloat)space;


/**
 设置字体大小和颜色
 
 @param loc 起始位置
 @param len 设置长度
 @param font 字体大小
 @param color 颜色
 */
- (void)setFontAndColorWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font color:(UIColor *)color;

/**
 设置两段颜色
 
 @param range1 第一段范围
 @param range2 第二段范围
 @param color 颜色
 */
- (void)setColorWithRange:(NSRange )range1 range2:(NSRange)range2 color:(UIColor *)color;


/**
 分别设置颜色与字体大小
 
 @param colorRange 颜色范围
 @param color 颜色
 @param fontRange 字体范围
 @param font 字体
 */
- (void)setColorWithRange:(NSRange)colorRange color:(UIColor *)color fontRange:(NSRange)fontRange font:(UIFont *)font;

/**
 设置文字 和颜色文字

 @param text 文字
 @param subString 颜色文字
 @param color 颜色
 */
- (void)setTextString:(NSString *)text AndColorSubString:(NSString *)subString color:(UIColor *)color;


/**
 设置文字 和字体变化文字

 @param text 文字
 @param subString 字体变化文字
 @param font 字体
 */
- (void)setTextString:(NSString *)text AndFontSubString:(NSString *)subString font:(UIFont *)font;

/**
 设置文字 和颜色 字体 文字

 @param text 文字
 @param subString 属性文字
 @param color 颜色
 @param font 字体
 */
- (void)setTextString:(NSString *)text AndColorSubString:(NSString *)subString color:(UIColor *)color font:(UIFont *)font;


/**
 左右对齐
 */
- (void)changeAligmentRightAndLeftWithWidth:(CGFloat )width;

/**
 分散对齐
 */
- (void)setFillsWords:(NSString *)words andWidth:(CGFloat )width;

- (void)toMoneyLabelStytle;

- (void)toMoneyLabelStytleWithFont:(UIFont *)font;

/**
 设置认证图标

 @param images 认证图标
 @param span 间距
 */
- (void)setAuthImages:(NSArray<UIImage *> *)images;


@end
