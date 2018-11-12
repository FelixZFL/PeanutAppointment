//
//  CustomNavigationBar.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "sys/utsname.h"

#define ITEM_WIDHT 44
#define ITEM_HEIHT 44

#define kDefaultTitleFont KBoldFont(17)
#define kDefaultTitleColor COLOR_UI_FFFFFF
#define kDefaultBackgroundColor COLOR_UI_THEME_RED


@interface CustomNavigationBar()

@property (nonatomic, strong) UILabel     *titleLable;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation CustomNavigationBar

+ (instancetype)CustomNavBar {
    CustomNavigationBar *navBar = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVITETION_HEIGHT)];
    return navBar;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLable];
    [self addSubview:self.rightButton];
    [self addSubview:self.rightButton1];
    [self addSubview:self.bottomLine];
    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = kDefaultBackgroundColor;
}

-(void)updateFrame {
    NSInteger top = ([CustomNavigationBar isIphoneX]) ? 44 : 20;
    NSInteger margin = 0;
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 44;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = SCREEN_WIDTH - (margin + buttonWidth)*2 - 20;
    
    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    self.leftButton.frame = CGRectMake(margin, top, buttonWidth, buttonHeight);
    self.rightButton.frame = CGRectMake(SCREEN_WIDTH - buttonWidth - margin, top, buttonWidth, buttonHeight);
    self.rightButton1.frame = CGRectMake(SCREEN_WIDTH - (buttonWidth + margin)*2, top, buttonWidth, buttonHeight);
    self.titleLable.frame = CGRectMake((SCREEN_WIDTH - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), SCREEN_WIDTH, 0.5);
}

#pragma mark - public -

- (void)setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)setTintColor:(UIColor *)color {
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleLable setTextColor:color];
}

#pragma mark - 左右按钮
- (void)setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.leftButton.hidden = NO;
    [self.leftButton setImage:normal forState:UIControlStateNormal];
    [self.leftButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
    //判断宽度
    CGFloat btnWidth = [title getWidthWithFont:KFont(14)];
    if (btnWidth > 44) {
        CGRect rect = self.leftButton.frame;
        rect.size.width = btnWidth + 5;
        self.leftButton.frame = rect;
    }
}

- (void)setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self setLeftButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)setLeftButtonWithImage:(UIImage *)image {
    [self setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

- (void)setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton.hidden = NO;
    [self.rightButton setImage:normal forState:UIControlStateNormal];
    [self.rightButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
    //判断宽度
    CGFloat btnWidth = [title getWidthWithFont:KFont(14)];
    if (btnWidth > 44) {
        CGRect rect = self.rightButton.frame;
        rect.size.width = btnWidth + 5;
        rect.origin.x = rect.origin.x - (btnWidth + 5 - 44);
        self.rightButton.frame = rect;
    }
}
- (void)setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self setRightButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)setRightButtonWithImage:(UIImage *)image {
    [self setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}


- (void)setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton1.hidden = NO;
    [self.rightButton1 setImage:normal forState:UIControlStateNormal];
    [self.rightButton1 setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton1 setTitle:title forState:UIControlStateNormal];
    [self.rightButton1 setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setRightButton1WithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setRightButton1WithNormal:image highlighted:image title:title titleColor:titleColor];
}
- (void)setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self setRightButton1WithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}
- (void)setRightButton1WithImage:(UIImage *)image {
    [self setRightButton1WithNormal:image highlighted:image title:nil titleColor:nil];
}
- (void)setRightButton1WithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self setRightButton1WithNormal:nil highlighted:nil title:title titleColor:titleColor];
}


#pragma mark - setter

- (void)setNavStyle:(CustomNavStyle)navStyle {
    
    if (navStyle == CustomNavStyle_Default) {
        [self setBarBackgroundColor:COLOR_UI_FFFFFF];
        [self setTitleLabelColor:COLOR_UI_222222];
        self.bottomLine.hidden = NO;
    }else if (navStyle == CustomNavStyle_Light) {
        [self setBarBackgroundColor:COLOR_UI_THEME_RED];
        [self setTitleLabelColor:COLOR_UI_FFFFFF];
        self.bottomLine.hidden = YES;
    }
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = _title;
    self.titleView.hidden = YES;
    self.titleLable.hidden = NO;
}

- (void)setTitleView:(UIView *)titleView {
    
    [_titleView removeFromSuperview];
    _titleView = nil;
    _titleView = titleView;
    [self addSubview:titleView];
    self.titleLable.hidden = YES;
    self.titleView.hidden = NO;
    
    titleView.centerX = self.centerX;
    titleView.centerY = NAVITETION_HEIGHT -  22;
    
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLable.textColor = _titleLabelColor;
}
- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = _titleLabelFont;
}
-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.backgroundColor = _barBackgroundColor;
    self.backgroundImageView.hidden = YES;
    self.backgroundView.hidden = NO;
}
- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.image = _barBackgroundImage;
    self.backgroundView.hidden = YES;
    self.backgroundImageView.hidden = NO;
}

#pragma mark - private -

+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

-(void)clickBack:(UIButton *)sender {
    if (self.onClickLeftButton) {
        self.onClickLeftButton(sender);
    } else {
        UIViewController *currentVC = [UIViewController fl_currentViewController];
        [currentVC fl_toLastViewController];
    }
}
-(void)clickRight:(UIButton *)sender {
    if (self.onClickRightButton) {
        self.onClickRightButton(sender);
    }
}
-(void)clickRight1:(UIButton *)sender {
    if (self.onClickRightButton1) {
        self.onClickRightButton1(sender);
    }
}
#pragma mark - getter -
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.titleLabel.font = KFont(14);
        [_leftButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.hidden = YES;
    }
    return _leftButton;
}
-(UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = KFont(14);
        [_rightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.hidden = YES;
    }
    return _rightButton;
}

- (UIButton *)rightButton1 {
    if (!_rightButton1) {
        _rightButton1 = [[UIButton alloc] init];
        _rightButton1.titleLabel.font = KFont(14);
        [_rightButton1 addTarget:self action:@selector(clickRight1:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton1.imageView.contentMode = UIViewContentModeCenter;
        _rightButton1.hidden = YES;
    }
    return _rightButton1;
}

-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = kDefaultTitleColor;
        _titleLable.font = kDefaultTitleFont;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.hidden = YES;
    }
    return _titleLable;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    }
    return _bottomLine;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

@end
