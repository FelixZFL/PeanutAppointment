//
//  HomeNoticeView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeNoticeView.h"

@interface HomeNoticeView()

@end

@implementation HomeNoticeView

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
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UIButton *noticeBtn = [[UIButton alloc] init];
    [noticeBtn setButtonStateNormalTitle:@" 通知" Font:KFont(12) textColor:COLOR_UI_000000];
    [noticeBtn setImage:imageNamed(@"home_icon_notification") forState:UIControlStateNormal];
    [self addSubview:noticeBtn];
    
    [self addSubview:self.contentLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeBtn.mas_right).with.mas_offset(MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 30;
}


#pragma mark - getter -

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setLabelFont:KFont(12) textColor:COLOR_UI_000000 textAlignment:NSTextAlignmentLeft];
        [_contentLabel setTextString:@"小姐姐已经上线拉" AndColorSubString:@"小姐姐" color:COLOR_UI_THEME_RED];
    }
    return _contentLabel;
}

@end
