//
//  CustomNavigationBar.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CustomNavStyle_Default,//白色底色  黑色图标 黑色标题  黑色按钮
    CustomNavStyle_Light,//绿色底色  白色图标 白色标题  白色按钮
} CustomNavStyle;


@interface CustomNavigationBar : UIView


@property (nonatomic, copy) void(^onClickLeftButton)(UIButton *btn);
@property (nonatomic, copy) void(^onClickRightButton)(UIButton *btn);
@property (nonatomic, copy) void(^onClickRightButton1)(UIButton *btn);

@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIButton    *rightButton1;

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavBar;

- (void)setBottomLineHidden:(BOOL)hidden;
- (void)setBackgroundAlpha:(CGFloat)alpha;
- (void)setTintColor:(UIColor *)color;

// 默认返回事件
- (void)setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)setLeftButtonWithImage:(UIImage *)image;
- (void)setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)setRightButtonWithImage:(UIImage *)image;
- (void)setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)setRightButton1WithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)setRightButton1WithImage:(UIImage *)image;
- (void)setRightButton1WithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)setNavStyle:(CustomNavStyle)navStyle;

@end
