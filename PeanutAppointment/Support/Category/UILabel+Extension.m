//
//  UILabel+Extension.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/20.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    [label setLabelFont:font textColor:color textAlignment:textAlignment];
    return label;
}

- (void)setLabelFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment {
    self.font = font;
    self.textColor = color;
    self.textAlignment = textAlignment;
}


-(void)setLineParagrp:(CGFloat)lineSpace{
    NSTextAlignment align = self.textAlignment;
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:lineSpace];
        [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [self.text length])];
        self.attributedText = mutableStr;
    }
    self.textAlignment = align;
}

-(void)setColorWithLoc:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color{
    
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        self.attributedText = mutableStr;
    }
    
}

-(void)setColorWithLoc:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color space:(CGFloat)space{
    
    NSTextAlignment align = self.textAlignment;
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:space];
        [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [self.text length])];
        
        self.attributedText = mutableStr;
        
    }
    self.textAlignment = align;
    
}
-(void)setColorAndLineWith:(NSInteger)loc len:(NSInteger)len color:(UIColor *)color{
    
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        //加下划线
        [mutableStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(loc, len)];
        self.attributedText = mutableStr;
        
    }
    
}
-(void)setFontWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font{
    
    if (self.text) {
        
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(loc, len)];
        
        self.attributedText = mutableStr;
    }
    
    
}
-(void)setFontWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font space:(CGFloat)space{
    NSTextAlignment align = self.textAlignment;
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(loc, len)];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:space];
        [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [self.text length])];
        
        self.attributedText = mutableStr;
        
    }
    self.textAlignment = align;
}

-(void)setFontAndColorWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font color:(UIColor *)color space:(CGFloat)space{
    NSTextAlignment align = self.textAlignment;
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(loc, len)];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:space];
        [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [self.text length])];
        
        self.attributedText = mutableStr;
        
    }
    self.textAlignment = align;
}
- (void)setFontAndColorWithLoc:(NSInteger)loc len:(NSInteger)len font:(UIFont *)font color:(UIColor *)color{
    NSTextAlignment align = self.textAlignment;
    if (self.text) {
        
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(loc, len)];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        
        self.attributedText = mutableStr;
    }
    
    self.textAlignment = align;
    
}
- (void)setColorWithLoc:(NSInteger)loc len:(NSInteger)len loc1:(NSInteger)loc1 len1:(NSInteger)len1 color:(UIColor *)color{
    
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc, len)];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color     range:NSMakeRange(loc1, len1)];
        self.attributedText = mutableStr;
        
    }
    
}

- (void)setColorWithRange:(NSRange)range1 range2:(NSRange)range2 color:(UIColor *)color {
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color range:range1];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color range:range2];
        self.attributedText = mutableStr;
        
    }
}

- (void)setColorWithRange:(NSRange)colorRange color:(UIColor *)color fontRange:(NSRange)fontRange font:(UIFont *)font{
    if (self.text) {
        NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutableStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
        [mutableStr addAttribute:NSFontAttributeName value:font range:fontRange];
        self.attributedText = mutableStr;
        
    }
}

- (void)setTextString:(NSString *)text AndColorSubString:(NSString *)subString color:(UIColor *)color {
    if (text.length > 0) {
        self.text = text;
        NSRange range = [text rangeOfString:subString];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
            [mutableStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            self.attributedText = mutableStr;
        }
    }
}

- (void)setTextString:(NSString *)text AndFontSubString:(NSString *)subString font:(UIFont *)font {
    if (text.length > 0) {
        self.text = text;
        NSRange range = [text rangeOfString:subString];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
            [mutableStr addAttribute:NSFontAttributeName value:font range:range];
            self.attributedText = mutableStr;
        }
    }
}


- (void)setTextString:(NSString *)text AndColorSubString:(NSString *)subString color:(UIColor *)color font:(UIFont *)font{
    if (text.length > 0) {
        self.text = text;
        NSRange range = [text rangeOfString:subString];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:self.text];
            [mutableStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            [mutableStr addAttribute:NSFontAttributeName value:font range:range];
            self.attributedText = mutableStr;
        }
    }
}

- (void)changeAligmentRightAndLeftWithWidth:(CGFloat )width {
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    CGFloat margin = (width - textSize.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:(id)NSKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
}

- (void)setFillsWords:(NSString *)words andWidth:(CGFloat )width {
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:words];
    if(words.length==0||words.length==1){
        return;
    }
    UILabel * lab = [[UILabel alloc] init];
    lab.font = self.font;
    lab.attributedText = attrStr;
    [lab sizeToFit];
    CGFloat offsetWidth;
    offsetWidth=(width-lab.frame.size.width)/(words.length-1);
    [attrStr addAttribute:NSKernAttributeName value:@(offsetWidth) range:NSMakeRange(0, attrStr.length-1)];
    self.attributedText = attrStr;
}

- (void)toMoneyLabelStytle {
    
    [self toMoneyLabelStytleWithFont:KFont(10)];
    
}

- (void)toMoneyLabelStytleWithFont:(UIFont *)font {
    if ([self.text rangeOfString:@"￥"].length != NSNotFound) {
        NSRange range = [self.text rangeOfString:@"￥"];
        //        NSLog(@"range======= %ld,%ld",range.location,range.length);
        [self setFontWithLoc:range.location len:range.length font:font];
    }
}

- (void)setAuthImages:(NSArray<UIImage *> *)images {
    NSMutableAttributedString *textAttrStr = [[NSMutableAttributedString alloc] init];
    
    for (UIImage *img in images) {//遍历添加标签
        
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = img;
        //计算图片大小，与文字同高，按比例设置宽度
        CGFloat imgH = self.font.pointSize;
        CGFloat imgW = (img.size.width / img.size.height) * imgH;
        //计算文字padding-top ，使图片垂直居中
        CGFloat textPaddingTop = (self.font.lineHeight - self.font.pointSize) / 2;
        attach.bounds = CGRectMake(0, -textPaddingTop , imgW, imgH);
        
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attach];
        [textAttrStr appendAttributedString:imgStr];
        //标签后添加空格
        [textAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }
    //设置间距
    if ( textAttrStr.length > 0) {
        [textAttrStr addAttribute:NSKernAttributeName value:@(3) range:NSMakeRange(0, textAttrStr.length)];
    }
    
    self.attributedText = textAttrStr;
}


@end
