//
//  FeedbackHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "FeedbackHeadView.h"

@interface FeedbackHeadView()

@end

@implementation FeedbackHeadView

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
    
    UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.width.mas_equalTo(60);
    }];
    titleLabel.text = @"问题描述";
    [titleLabel changeAligmentRightAndLeftWithWidth:60];
    
    self.feedBackTextView = [[CustomPlaceholderTextView alloc] init];
    [self addSubview:self.feedBackTextView];
    [self.feedBackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(MARGIN_5);
        make.bottom.mas_equalTo(-MARGIN_5);
    }];
    
    UIView *bottomLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

#pragma mark - public -

+ (CGFloat )getHeight {
    
    return 150;
}

#pragma mark - action -

#pragma mark - getter -


@end
