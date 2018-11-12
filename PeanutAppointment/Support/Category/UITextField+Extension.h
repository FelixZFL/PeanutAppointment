//
//  UITextField+Extension.h
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extension)


+ (UITextField *)textFieldWithFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment;
- (void)setTextFieldFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment;


@end

NS_ASSUME_NONNULL_END
