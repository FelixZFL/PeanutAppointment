//
//  CardAuthHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CardAuthHeadView.h"
#import "BXTextField.h"

@interface CardAuthHeadView()<UITextFieldDelegate>

@end

@implementation CardAuthHeadView

#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
    
}
#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    for (int i = 0; i < 2; i++) {
        
        UITextField *textField = i == 0 ?  [[UITextField alloc] init] : [[BXTextField alloc] init];
        [textField setTextColor:COLOR_UI_222222];
        [textField setDefaultCorner];
        [textField setborderColor:COLOR_UI_999999];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = KFont(14);
        textField.delegate = self;
        [self addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(MARGIN_25 + i * (40 + 35));
        }];
        
        if (i == 0) {
            UILabel *hintLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
            hintLabel.text = @"支付宝提现账户必须为该用户名下";
            [self addSubview:hintLabel];
            [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(textField.mas_bottom);
                make.height.mas_equalTo(35);
                make.left.mas_equalTo(MARGIN_15);
                make.right.mas_equalTo(-MARGIN_15);
            }];
            
            textField.placeholder = @"请输入真实姓名";
            self.nameTF = textField;
        } else {
            textField.placeholder = @"请输入身份证号码";
            self.cardTF = textField;
        }
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return (MARGIN_25 + 40) * 2 + 35 + MARGIN_10;
}

#pragma mark - UITextFieldDelegate -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.cardTF) {
        if (string.length > 0) {
            NSString *newString = [NSString stringWithFormat:@"%@%@",textField.text,string];
            if (newString.length > 18) {
                return NO;
            }
        }
    }
    return YES;
}


@end
