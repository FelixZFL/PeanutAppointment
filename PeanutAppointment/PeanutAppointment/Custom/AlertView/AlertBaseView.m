//
//  AlertBaseView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AlertBaseView.h"

#define AlertBaseViewWidth 270
#define AlertButtonHeight 45

@interface AlertBaseView()

@property (nonatomic, copy) AlertItemClickBlock leftBlock;
@property (nonatomic, copy) AlertItemClickBlock rightBlock;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) UIView *layerView;

@end

@implementation AlertBaseView

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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MARGIN_25);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    UIView *hLine = [[UIView alloc] init];
    hLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AlertButtonHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
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
    
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hLine.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.centerX.equalTo(hLine.mas_centerX);
        make.width.mas_equalTo(LINE_HEIGHT);
    }];
    self.vLine = vLine;
    
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
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype ) alertWithTitle:(NSString *)title leftBtn:(NSString *)leftBtn leftBlock:(AlertItemClickBlock)leftBlock rightBtn:(NSString *)rightBtn rightBlock:(AlertItemClickBlock)rightBlock {
    
    CGFloat height = [title getHeightWithMaxWidth:AlertBaseViewWidth - 35 * 2 font:KFont(17) lineSpacing:LINE_SPACE_5] + MARGIN_25*2 + AlertButtonHeight;
    
    AlertBaseView *alert = [[AlertBaseView alloc] initWithFrame:CGRectMake(0, 0, AlertBaseViewWidth, height)];
    alert.leftBlock = leftBlock;
    alert.rightBlock = rightBlock;
    alert.titleLabel.text = title;
    [alert.titleLabel setLineParagrp:LINE_SPACE_5];
    
    
    if (leftBtn) {
        [alert.leftBtn setButtonStateNormalTitle:leftBtn];
    }
    if (rightBtn) {
        [alert.rightBtn setButtonStateNormalTitle:rightBtn];
    }
    if (leftBtn && rightBtn) {
        alert.leftBtn.hidden = NO;
        alert.rightBtn.hidden = NO;
        alert.vLine.hidden = NO;
        
        [alert.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        }];
        [alert.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AlertBaseViewWidth/2.f);
        }];
        
    }else if (!rightBtn) {
        alert.rightBtn.hidden = YES;
        alert.leftBtn.hidden = NO;
        alert.vLine.hidden = YES;
        
        [alert.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [alert.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AlertBaseViewWidth);
        }];
        
    }else if (!leftBtn) {
        alert.rightBtn.hidden = NO;
        alert.leftBtn.hidden = YES;
        alert.vLine.hidden = YES;
        
        [alert.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(AlertBaseViewWidth);
        }];
        [alert.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
    }else {
        return nil;
    }
    return alert;
}

#pragma mark - action -

- (void)leftBtnAction {
    
    if (self.leftBlock) {
        self.leftBlock();
    }
    
    [self removFromWindow];
}

- (void)rightBtnAction {
    
    if (self.rightBlock) {
        self.rightBlock();
    }
    
    [self removFromWindow];
}

#pragma mark - getter -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel  setLabelFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setLineParagrp:LINE_SPACE_5];
    }
    return _titleLabel;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setButtonStateNormalTitle:@"" Font:KFont(17) textColor:COLOR_UI_666666];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn setButtonStateNormalTitle:@"" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setBackgroundColor:COLOR_UI_THEME_RED];
    }
    return _rightBtn;
}

@end
