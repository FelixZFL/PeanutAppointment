//
//  VersionUpdateAlertView.m
//  shopping
//
//  Created by XB on 2018/5/2.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "VersionUpdateAlertView.h"
#import "VersionModel.h"

#define AlertBaseViewWidth 270
#define AlertButtonHeight 45

@interface VersionUpdateAlertView()

//@property (nonatomic, copy) AlertokBlock okBlock;
//@property (nonatomic, copy) AlertCancelBlock cancelBlock;

@property (nonatomic, strong) UILabel *currentVersionLabel;
@property (nonatomic, strong) UILabel *targetVersionLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *okBtn;

@property (nonatomic, strong) UIView *layerView;


@end


@implementation VersionUpdateAlertView

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
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    [self setDefaultCorner];
    
    __weak __typeof(self)weakSelf = self;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setLabelFont:KBoldFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
    titleLabel.text = @"检测到新版本";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UIView *topLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
        make.bottom.equalTo(titleLabel);
    }];
    
    
    [self addSubview:self.currentVersionLabel];
    [self.currentVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(15);
    }];
    
    [self addSubview:self.targetVersionLabel];
    [self.targetVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.currentVersionLabel.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(15);
    }];
    
    UIView *hLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.targetVersionLabel.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UILabel *contentTitleLabel = [[UILabel alloc] init];
    [contentTitleLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    contentTitleLabel.text = @"版本更新内容:";
    [self addSubview:contentTitleLabel];
    [contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hLine.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo(15);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentTitleLabel.mas_bottom).with.mas_offset(MARGIN_15);
        make.left.mas_equalTo(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_10);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        make.height.mas_equalTo(AlertButtonHeight);
    }];
    
    [self addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        make.height.mas_equalTo(AlertButtonHeight);
    }];
    
    
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        for (UIView *view in window.subviews) {
            if ([view isKindOfClass:[self class]]) {
                VersionUpdateAlertView *alert = (VersionUpdateAlertView *)view;
                [alert removFromWindow];
            }
        }
    }
    
//    [window removeAllSubviews];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.5);
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

+ (instancetype )alertWithModel:(VersionModel *)model {
    
    NSString *string = [model.described stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    CGFloat height = [string getHeightWithMaxWidth:AlertBaseViewWidth - MARGIN_10 * 2 font:KFont(14) lineSpacing:LINE_SPACE_5] + 40 + MARGIN_15*6 + 15*3 +  AlertButtonHeight;
    
    VersionUpdateAlertView *alert = [[VersionUpdateAlertView alloc] initWithFrame:CGRectMake(0, 0, AlertBaseViewWidth, height)];
    if ([model.isUpdate integerValue] == 1) {//强制更新
        [alert.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [alert.okBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AlertBaseViewWidth);
        }];
        [alert.okBtn setButtonStateNormalTitle:@"确认更新"];
    }
    NSString *currentVersion = kCurrentShortVersion;
    alert.currentVersionLabel.text = [NSString stringWithFormat:@"当前版本：%@",currentVersion];
    [alert.currentVersionLabel setFontAndColorWithLoc:5 len:[currentVersion length] font:KFont(14) color:COLOR_UI_222222];
    
    NSString *targetVersion = model.iosSerialNumber;
    alert.targetVersionLabel.text = [NSString stringWithFormat:@"目标版本：%@",targetVersion];
    [alert.targetVersionLabel setFontAndColorWithLoc:5 len:[targetVersion length] font:KFont(14) color:COLOR_UI_222222];
    
    alert.contentLabel.text = string;
    
    return alert;
}

#pragma mark - action -

- (void)cancelBtnAction {
    
    [self removFromWindow];
}

- (void)okBtnAction {
//    // 评分页面地址
//    NSString *scoreStr = [NSString stringWithFormat:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",AppleAppId];
//        NSString *appStr = @"https://itunes.apple.com/app/apple-store/id1317248738?pt=118536605&ct=web&mt=8";
    // 应用地址
    NSString *appStr =[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",AppleAppId];
    // 判断系统用对应方法 1240719357
//    if ( @available(iOS 10 , * )) {
//        // 跳转
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStr] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(YES)} completionHandler:^(BOOL success) {
//            NSLog(@"将要进入 App Store 页面了");
//        }];
//    } else {
//    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStr]];
    
    
    [self removFromWindow];
}

#pragma mark - getter -

- (UILabel *)currentVersionLabel {
    if (!_currentVersionLabel) {
        _currentVersionLabel = [[UILabel alloc] init];
        [_currentVersionLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _currentVersionLabel.text = @"当前版本：";
    }
    return _currentVersionLabel;
}

- (UILabel *)targetVersionLabel {
    if (!_targetVersionLabel) {
        _targetVersionLabel = [[UILabel alloc] init];
        [_targetVersionLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _targetVersionLabel.text = @"目标版本：";
    }
    return _targetVersionLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines = 0;
        [_contentLabel setLineParagrp:LINE_SPACE_5];
    }
    return _contentLabel;
}


- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setButtonStateNormalTitle:@"稍后更新" Font:KFont(17) textColor:COLOR_UI_666666];
        [_cancelBtn setborderColor:COLOR_UI_F0F0F0 ];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] init];
        [_okBtn setButtonStateNormalTitle:@"立即更新" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        _okBtn.backgroundColor = COLOR_UI_THEME_RED;
        [_okBtn setBackgroundImage:imageNamed(@"alert_btn_bg") forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}


@end
