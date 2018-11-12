//
//  ChangePasswordHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ChangePasswordHeadView.h"
#import "VerificationCodeTextField.h"
#import "PasswordTextField.h"

@interface ChangePasswordHeadView()

@property (nonatomic, strong) BaseTextField *phoneTF;//手机号
@property (nonatomic, strong) VerificationCodeTextField *codeTF;//验证码
@property (nonatomic, strong) PasswordTextField *passwordTF;//密码
@property (nonatomic, strong) PasswordTextField *rePasswordTF;//重复密码

@property (nonatomic, strong) UIButton *confirmButton;//提交

@end

@implementation ChangePasswordHeadView

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
    
    __weak __typeof(self)weakSelf = self;
    
    CGFloat textFieldHeight = 40;
    
    [self addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MARGIN_25);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(textFieldHeight);
    }];
    
    [self addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneTF.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(textFieldHeight);
    }];
    
    [self addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeTF.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(textFieldHeight);
    }];
    
    [self addSubview:self.rePasswordTF];
    [self.rePasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTF.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(textFieldHeight);
    }];

    
    [self addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.rePasswordTF.mas_bottom).with.mas_offset(MARGIN_25);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return MARGIN_25 * 2 + 40 * 4 + MARGIN_15 * 3 + BUTTON_HEIGHT_50;
}

#pragma mark - action -

- (void)confirmButtonAction {
    if (self.phoneTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (![self.phoneTF.text valiMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    if (self.codeTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        [self.codeTF becomeFirstResponder];
        return;
    }
    if (self.passwordTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请设置登录密码"];
        [self.passwordTF becomeFirstResponder];
        return;
    }
    if (self.rePasswordTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请确认登录密码"];
        [self.rePasswordTF becomeFirstResponder];
        return;
    }
    if (![self.passwordTF.text isEqualToString:self.rePasswordTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"确认登陆密码输入不一致"];
        [self.rePasswordTF becomeFirstResponder];
        return;
    }
    
    [self endEditing:YES];
    
    if (self.confirmBlock) {
        self.confirmBlock(self.phoneTF.text, self.codeTF.text, self.passwordTF.text);
    }
}


- (void)verificationCodeAction:(UIButton *)sender {
    if (self.phoneTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (![self.phoneTF.text valiMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    [YQNetworking postWithApiNumber:API_NUM_20016 params:@{@"phone":self.phoneTF.text} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            
            __block int time = 60;
            __block UIButton *verifybutton = sender;
            verifybutton.enabled = NO;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(time<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [verifybutton setTitle:@"获取验证码" forState:UIControlStateNormal];
                        verifybutton.enabled = YES;
                    });
                }else{
                    
                    time--;
                    int seconds = time % 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *strTime = [NSString stringWithFormat:@"%d秒后重发",seconds];
                        [verifybutton setTitle:strTime forState:UIControlStateNormal];
                    });
                }
            });
            dispatch_resume(_timer);
        }
    } failBlock:nil];
    
}

#pragma mark - getter -

- (BaseTextField *)phoneTF {
    if (!_phoneTF) {
        _phoneTF = [[BaseTextField alloc] init];
        _phoneTF.placeholder = @"请输入手机号";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTF;
}

- (VerificationCodeTextField *)codeTF {
    if (!_codeTF) {
        _codeTF = [[VerificationCodeTextField alloc] init];
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        [_codeTF.verificationCodeBtn addTarget:self action:@selector(verificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeTF;
}

- (PasswordTextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[PasswordTextField alloc] init];
        _passwordTF.placeholder = @"请输入6-16位密码，区分大小写";
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _passwordTF;
}

- (PasswordTextField *)rePasswordTF {
    if (!_rePasswordTF) {
        _rePasswordTF = [[PasswordTextField alloc] init];
        _rePasswordTF.placeholder = @"请再次输入密码";
        _rePasswordTF.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _rePasswordTF;
}


- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setButtonStateNormalTitle:@"提交" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        _confirmButton.backgroundColor = COLOR_UI_THEME_RED;
        [_confirmButton setDefaultCorner];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


@end
