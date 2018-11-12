//
//  NSString+Extension.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

///获取字符串高度
- (CGFloat)getHeightWithMaxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font lineSpacing:(CGFloat )lineSpacing;
///获取字符串高度
- (CGFloat)getHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat )lineSpacing;
///获取字符串高度
- (CGFloat)getHeightWithMaxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font;
///获取字符串高度
- (CGFloat)getHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font;

//获取字符串宽度
- (CGFloat)getWidthWithMaxSize:(CGSize )maxSize font:(UIFont *)font;
//获取字符串宽度
- (CGFloat)getWidthWithFont:(UIFont *)font ;

///转为价格字符串
- (NSString *)toMoneySting;

///替换字符串中的部分字符为星号
- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length;

/**
 校验手机号码
 @return 校验手机号码是否正确结果
 */
- (BOOL)valiMobile;

///是否包含汉字字符
- (BOOL)hasChinese;

/// 匹配身份证号码
-(BOOL)isHxIdentityCard;

///验证密码
- (BOOL)isValiPassword;

///验证是否全是数字
- (BOOL)isAllNumber;

/**
 获取分散对齐AttributedString
 @param width 宽度
 @param font 字体大小
 @return 分散对齐AttributedString
 */
-(NSMutableAttributedString*)fillWordsWithWidth:(CGFloat)width andFont:(UIFont*)font;


@end
