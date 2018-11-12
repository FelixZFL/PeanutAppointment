//
//  VerificationCodeTextField.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "VerificationCodeTextField.h"

@implementation VerificationCodeTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnWidth = 100;
        
        [self addSubview:self.verificationCodeBtn];
        [self.verificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(btnWidth);
        }];
        
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, 0)];
        self.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

#pragma mark - getter -

- (UIButton *)verificationCodeBtn {
    if (!_verificationCodeBtn) {
        _verificationCodeBtn = [UIButton buttonStateNormalTitle:@"获取验证码" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        _verificationCodeBtn.backgroundColor = COLOR_UI_THEME_RED;
    }
    return _verificationCodeBtn;
}

@end
