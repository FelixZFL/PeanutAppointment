//
//  DemandDetailHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "DemandDetailHeadView.h"

#define SingleViewHeight 50.f

@interface DemandDetailHeadView()

@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UILabel *returnLabel;

@end

@implementation DemandDetailHeadView

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
    
    self.backgroundColor = COLOR_UI_F0F0F0;
    
    CGFloat marginLeft = 85;
    
    NSArray *titleArray = @[@"类别",@"发布时间",@"结束时间",@"性别要求",@"服务方式"];
    UIView *lastView = nil;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [UIView viewWithColor:COLOR_UI_FFFFFF];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(0) : make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(35);
        }];
        
        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [singleView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        titleLabel.numberOfLines = 0;
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
            make.width.mas_equalTo(60);
        }];
        [titleLabel changeAligmentRightAndLeftWithWidth:60];
        
        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        [singleView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft);
            make.right.mas_equalTo(-MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
        }];
        
        if (i == 0) {
            contentLabel.text = @"棋牌";
        } else if (i == 1) {
            contentLabel.text = @"2018-08-30";
        } else if (i == 2) {
            contentLabel.text = @"2018-08-30";
        } else if (i == 3) {
            contentLabel.text = @"不限";
        } else if (i == 4) {
            contentLabel.text = @"客户找我·我去找客户";
        }
        lastView = singleView;
    }
    
    UILabel *hintLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
    hintLabel.numberOfLines = 0;
    NSString *str1 = @"已有1位应邀服务者";
    NSString *str2 = @"为了保证您的合法权益，未见到服务者之前请不要按确认";
    [hintLabel setTextString:[NSString stringWithFormat:@"%@\n%@",str1,str2] AndFontSubString:str2 font:KFont(12)];
    [self addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 35 * 5 + 60;
}

#pragma mark - action -

#pragma mark - getter -


@end
