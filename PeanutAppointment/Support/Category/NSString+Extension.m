//
//  NSString+Extension.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (CGFloat)getHeightWithMaxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font lineSpacing:(CGFloat )lineSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

- (CGFloat)getHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat )lineSpacing {
    return [self getHeightWithMaxWidth:width maxHeight:CGFLOAT_MAX font:font lineSpacing:lineSpacing];
}

- (CGFloat)getHeightWithMaxWidth:(CGFloat)width maxHeight:(CGFloat)height font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

- (CGFloat)getHeightWithMaxWidth:(CGFloat)width font:(UIFont *)font {
    return [self getHeightWithMaxWidth:width maxHeight:CGFLOAT_MAX font:font];
}

- (CGFloat)getWidthWithMaxSize:(CGSize )maxSize font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.width;
}

- (CGFloat)getWidthWithFont:(UIFont *)font {
    return [self getWidthWithMaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:font];
}

///转为价格字符串
- (NSString *)toMoneySting {
    
    return [NSString stringWithFormat:@"￥%.2f",[self doubleValue]];
    
}


- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length {
    NSString *replaceStr = self;
    if (startLocation >= 0 && length >= 0 && self.length >= startLocation + length) {
        for (NSInteger i = 0; i < length; i++) {
            NSRange range = NSMakeRange(startLocation, 1);
            replaceStr = [replaceStr stringByReplacingCharactersInRange:range withString:@"*"];
            startLocation ++;
        }
    }
    return replaceStr;
}

/**
 校验手机号码
 @return 校验手机号码是否正确结果
 */
- (BOOL)valiMobile {
    NSString *mobile = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        
        NSString *PHONE_NUM = @"^((13)|(14)|(15)|(16)|(17)|(18)|(19))\\d{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHONE_NUM];
        BOOL isMatch = [pred evaluateWithObject:mobile];
        
        if (isMatch) {
            return YES;
        }else{
            return NO;
        }
    }
}
///是否包含汉字字符
- (BOOL)hasChinese {
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

// 匹配身份证号码
-(BOOL)isHxIdentityCard
{
    // 判断位数
    if ([self length] != 15 && [self length] != 18)
    {
        return NO;
    }
    
    NSString *carid = self;
    long lSumQT  =0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    // 判断年月日是否有效
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if( 18 != strlen(PaperId)) return -1;
    // 校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

-(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

///验证密码
- (BOOL)isValiPassword{
    
    NSString *password = @"^[A-Za-z0-9]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", password];
    
    return [pred evaluateWithObject:self];
}

///验证是否全是数字
- (BOOL)isAllNumber {
    NSString *str = self;
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

/*
 * 文本分散对齐
 */
-(NSMutableAttributedString*)fillWordsWithWidth:(CGFloat)width andFont:(UIFont*)font {
    
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(self.length==0||self.length==1){
        return attrStr;
    }
    UILabel * lab=[[UILabel alloc]init];
    lab.font=font;
    lab.attributedText=attrStr;
    [lab sizeToFit];
    CGFloat offsetWidth;
    offsetWidth=(width-lab.frame.size.width)/(self.length-1);
    [attrStr addAttribute:NSKernAttributeName value:@(offsetWidth) range:NSMakeRange(0, attrStr.length-1)];
    return attrStr;
}


@end
