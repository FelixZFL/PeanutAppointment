//
//  PasswordTextField.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PasswordTextField.h"

@interface PasswordTextField()

@property (nonatomic, strong) UIButton *eyeButton;

@end

@implementation PasswordTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.secureTextEntry = YES;
        
        CGFloat btnWidth = 40;
        
        [self addSubview:self.eyeButton];
        [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(btnWidth);
        }];
        
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnWidth, 0)];
        self.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

#pragma mark - action -

- (void)eyeButtonAction:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    self.secureTextEntry = !btn.selected;
    NSString *text = self.text;
    self.text = @" ";
    self.text = text;
    
    if (self.secureTextEntry)
    {
        [self insertText:self.text];
    }
    
}

#pragma mark - getter -

- (UIButton *)eyeButton {
    if (!_eyeButton) {
        _eyeButton = [[UIButton alloc] init];
        [_eyeButton setImage:imageNamed(@"password_eye_colsed") forState:UIControlStateNormal];
        [_eyeButton setImage:imageNamed(@"password_eye_opened") forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeButton;
}

@end
