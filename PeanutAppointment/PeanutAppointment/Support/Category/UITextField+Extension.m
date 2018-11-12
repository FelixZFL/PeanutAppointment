//
//  UITextField+Extension.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)


+ (UITextField *)textFieldWithFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment {
    UITextField *textField = [[UITextField alloc] init];
    [textField setTextFieldFont:font textColor:color textAlignment:textAlignment];
    return textField;
}
- (void)setTextFieldFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment {
    self.font = font;
    self.textColor = color;
    self.textAlignment = textAlignment;
}


@end
