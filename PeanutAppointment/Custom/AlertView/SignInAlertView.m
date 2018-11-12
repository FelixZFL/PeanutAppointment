//
//  SignInAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/13.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "SignInAlertView.h"


#define AlertBaseViewWidth 270
#define AlertButtonHeight 45

#define AlertImageHeight 45


static NSString * const signInTitleStr = @"每日签到可获得5~30积分奖励";
static NSString * const signInHintStr = @"说明第一天签到可获得5积分，第二天签到获得10积分，第三天签到获得15积分以此类推，最高获得30积分";


@interface SignInAlertView()

@property (nonatomic, copy) SignInAlertBtnBlock btnClickBlock;

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation SignInAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    [self setDefaultCorner];
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    __weak __typeof(self)weakSelf = self;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:imageNamed(@"alert_signIn_gift")];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MARGIN_20);
        make.width.height.mas_equalTo(AlertImageHeight);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom);
        make.height.mas_equalTo(65);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
    [self addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
    UIButton *soureBtn = [[UIButton alloc] init];
    [soureBtn setButtonStateNormalTitle:@"确定" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
    soureBtn.backgroundColor = COLOR_UI_THEME_RED;
    [soureBtn addTarget:self action:@selector(soureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:soureBtn];
    [soureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(AlertButtonHeight);
    }];
    
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.2);
    [self.layerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removFromWindow)]];
    [window addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.center = window.center;
    [window addSubview:self];
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithBlock:(SignInAlertBtnBlock )block {
    CGFloat hintHeight = [signInHintStr getHeightWithMaxWidth:AlertBaseViewWidth - MARGIN_15 * 2 font:KFont(12)];
    CGFloat height = MARGIN_20 + AlertImageHeight + 65 + hintHeight + MARGIN_15 + AlertButtonHeight;
    
    SignInAlertView *alert = [[SignInAlertView alloc] initWithFrame:CGRectMake(0, 0, AlertBaseViewWidth, height)];
    alert.btnClickBlock = block;
    return alert;
    
}

#pragma mark - action -

- (void)soureBtnAction {
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
    [self removFromWindow];
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel  setLabelFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = signInTitleStr;
    }
    return _titleLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel  setLabelFont:KFont(12) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _hintLabel.numberOfLines = 0;
        _hintLabel.text = signInHintStr;
    }
    return _hintLabel;
}


@end
