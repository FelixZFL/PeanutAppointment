//
//  PasswordAlertView.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PasswordAlertView.h"

#define AlertBaseViewWidth 270
#define AlertButtonHeight 45

@interface PasswordAlertView()

@property (nonatomic, copy) AuthSuccessBlock successBlock;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIView *layerView;

@end


@implementation PasswordAlertView

#pragma mark -- lifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    [self setDefaultCorner];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    __weak __typeof(self)weakSelf = self;
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    [self addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_25);
        make.right.mas_equalTo(-MARGIN_25);
        make.top.equalTo(topLine.mas_bottom).with.mas_offset(MARGIN_15);
        make.height.mas_equalTo(40);
    }];
    
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        make.height.mas_equalTo(AlertButtonHeight);
    }];
    
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        make.height.mas_equalTo(AlertButtonHeight);
    }];
    
    UIView *hLine = [[UIView alloc] init];
    hLine.backgroundColor = COLOR_UI_999999;
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AlertButtonHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hLine.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.centerX.equalTo(hLine.mas_centerX);
        make.width.mas_equalTo(LINE_HEIGHT);
    }];
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.2);
    [window addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.center = window.center;
    [window addSubview:self];
    
    [self.passwordTF becomeFirstResponder];
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithBlock:(AuthSuccessBlock )block {
    PasswordAlertView *alert = [[PasswordAlertView alloc] initWithFrame:CGRectMake(0, 0, AlertBaseViewWidth, 170)];
    alert.successBlock = block;
    return alert;
}

#pragma mark - action -

- (void)leftBtnAction {
    
    [self removFromWindow];
}

- (void)rightBtnAction {

    [self removFromWindow];
}

// 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary * userInfo = [aNotification userInfo];
    NSValue * aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"rect===%@",NSStringFromCGRect(keyboardRect));
    [UIView animateWithDuration:.4 animations:^{
                         self.center = CGPointMake(SCREEN_WIDTH/2.f, (SCREEN_HEIGHT - keyboardRect.size.height)/2.f);
                     }];
}
// 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:.4 animations:^{
                         self.center = CGPointMake(SCREEN_WIDTH/2.f, SCREEN_HEIGHT/2.f);
                     }];
}


#pragma mark - getter -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel  setLabelFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
        _titleLabel.text = @"请输入密码";
    }
    return _titleLabel;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [UITextField textFieldWithFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        [_passwordTF setDefaultCorner];
        _passwordTF.backgroundColor = COLOR_UI_F0F0F0;
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTF.secureTextEntry = YES;
        [_passwordTF setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, MARGIN_10, 0)]];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.placeholder = @"请输入密码";
    }
    return _passwordTF;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setButtonStateNormalTitle:@"取消" Font:KFont(17) textColor:COLOR_UI_666666];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setButtonStateNormalTitle:@"确定" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:COLOR_UI_THEME_RED];
    }
    return _rightBtn;
}

@end
