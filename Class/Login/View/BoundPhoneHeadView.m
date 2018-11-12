//
//  BoundPhoneHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BoundPhoneHeadView.h"
#import "VerificationCodeTextField.h"

@interface BoundPhoneHeadView()

@property (nonatomic, strong) BaseTextField *phoneTF;//手机号
@property (nonatomic, strong) VerificationCodeTextField *codeTF;//验证码

@property (nonatomic, strong) UIButton *confirmButton;//确认修改

@end

@implementation BoundPhoneHeadView

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
    
    [self addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.codeTF.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return MARGIN_25 + 40 * 2 + MARGIN_15 * 2 + BUTTON_HEIGHT_50;
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
    
    if (self.confirmBlock) {
        self.confirmBlock(self.phoneTF.text, self.codeTF.text);
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

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setButtonStateNormalTitle:@"确定" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        _confirmButton.backgroundColor = COLOR_UI_THEME_RED;
        [_confirmButton setDefaultCorner];
        [_confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


@end
