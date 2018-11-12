//
//  NavTypeChooseView.m
//  shopping
//
//  Created by XB on 2018/5/23.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "NavTypeChooseView.h"

@interface NavTypeChooseView()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) UIView *btnBottomLine;


@end

@implementation NavTypeChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = KColor(clearColor);
        
        [self addSubview:self.leftBtn];
        
        [self addSubview:self.rightBtn];
        
        self.btnBottomLine.frame = CGRectMake(self.leftBtn.centerX - 35, NavTypeChooseViewHeight - LINE_HEIGHT_3 - 0.5, 70, LINE_HEIGHT_3);
        [self addSubview:self.btnBottomLine];
    }
    return self;
}

#pragma mark - public -

- (void)setType:(NavTypeChooseViewType)type {
    _type = type;
    
    if (NavTypeChooseViewType_left == type) {
        self.leftBtn.titleLabel.font = KFont(17);
        self.rightBtn.titleLabel.font = KFont(14);
        
        self.btnBottomLine.centerX = self.leftBtn.centerX;
    }else {
        self.leftBtn.titleLabel.font = KFont(14);
        self.rightBtn.titleLabel.font = KFont(17);
        
        self.btnBottomLine.centerX = self.rightBtn.centerX;
    }
}

- (void)setleftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle {
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

#pragma mark - action -

- (void)navTypeChangeAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btnBottomLine.centerX = sender.centerX;
        
        if (sender.tag == self.leftBtn.tag) {
            self.leftBtn.titleLabel.font = KFont(17);
            self.rightBtn.titleLabel.font = KFont(14);
        }else {
            self.leftBtn.titleLabel.font = KFont(14);
            self.rightBtn.titleLabel.font = KFont(17);
        }
    }];
    
    if (self.navTypeChooseBlock) {
        self.navTypeChooseBlock(sender.tag == self.leftBtn.tag ? NavTypeChooseViewType_left : NavTypeChooseViewType_right);
    }
    
}
 
#pragma mark - getter -
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        _leftBtn.frame = CGRectMake(0, 0, NavTypeChooseViewWidth/2.f, NavTypeChooseViewHeight);
        [_leftBtn setButtonStateNormalTitle:@"" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        _leftBtn.tag = 100;
        [_leftBtn addTarget:self action:@selector(navTypeChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        _rightBtn.frame = CGRectMake(NavTypeChooseViewWidth/2.f, 0, NavTypeChooseViewWidth/2.f, NavTypeChooseViewHeight);
        [_rightBtn setButtonStateNormalTitle:@"" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
        _rightBtn.tag = 101;
        [_rightBtn addTarget:self action:@selector(navTypeChangeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIView *)btnBottomLine {
    if (!_btnBottomLine) {
        _btnBottomLine = [[UIView alloc] init];
        _btnBottomLine.backgroundColor = COLOR_UI_FFFFFF;
        [_btnBottomLine setCorner:LINE_HEIGHT_3/2.f];
    }
    return _btnBottomLine;
}

@end
