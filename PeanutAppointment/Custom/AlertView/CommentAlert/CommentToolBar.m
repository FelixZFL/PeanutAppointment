//
//  CommentToolBar.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CommentToolBar.h"

@interface CommentToolBar()

@end

@implementation CommentToolBar

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
    
    UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    [self addSubview:self.textV];
    [self addSubview:self.sendBtn];
    self.textV.frame = CGRectMake(MARGIN_15, MARGIN_10, SCREEN_WIDTH - MARGIN_15 - MARGIN_15, 50);
    self.sendBtn.frame = CGRectMake(SCREEN_WIDTH - MARGIN_15, MARGIN_10, 0, 50);
    
//    __weak __typeof(self)weakSelf = self;
//    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf);
//        make.left.mas_equalTo(MARGIN_15);
//        make.right.mas_equalTo(-MARGIN_15);
//        make.height.mas_equalTo(50);
//    }];
//
//    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf);
//        make.right.mas_equalTo(-MARGIN_15);
//        make.width.mas_equalTo(0);
//        make.height.mas_equalTo(50);
//    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 70;
}


#pragma mark - getter -

- (CustomPlaceholderTextView *)textV {
    if (!_textV) {
        _textV = [[CustomPlaceholderTextView alloc] init];
        _textV.textColor = COLOR_UI_222222;
        _textV.font = KFont(12);
        _textV.placeholder = @"我要评论";
        [_textV setCorner:CORNER_10];
        _textV.backgroundColor = COLOR_UI_F0F0F0;
    }
    return _textV;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setButtonStateNormalTitle:@"发送" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
        _sendBtn.backgroundColor = COLOR_UI_THEME_RED;
        [_sendBtn setCorner:CORNER_10];
    }
    return _sendBtn;
}

@end
