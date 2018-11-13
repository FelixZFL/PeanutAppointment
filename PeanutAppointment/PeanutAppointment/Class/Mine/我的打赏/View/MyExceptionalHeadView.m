//
//  MyExceptionalHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyExceptionalHeadView.h"

#import "MyExceptionalModel.h"

#define SingleViewHeight 50.f

@interface MyExceptionalHeadView()

@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UILabel *returnLabel;

@end

@implementation MyExceptionalHeadView

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
    
    
    UIView *topView = [UIView viewWithColor:COLOR_UI_THEME_RED];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(62);
    }];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] init];
        [topView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * SCREEN_WIDTH/2);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(MARGIN_15);
            make.left.right.mas_equalTo(0);
        }];
        UILabel *moneyLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-MARGIN_10);
            make.left.right.mas_equalTo(0);
        }];
        if (i == 0) {
            UIView *vLine = [UIView viewWithColor:COLOR_UI_FFFFFF];
            [view addSubview:vLine];
            [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.centerY.equalTo(view);
                make.width.mas_equalTo(LINE_HEIGHT);
                make.height.mas_equalTo(30);
            }];
            titleLabel.text = @"获得金钻";
            moneyLabel.text = @"203枚";
            self.receiveLabel = moneyLabel;
        } else {
            titleLabel.text = @"金钻返利";
            moneyLabel.text = @"￥203.00";
            self.returnLabel = moneyLabel;
        }
    }
    
    UILabel *hintLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
    hintLabel.numberOfLines = 0;
    hintLabel.text = @"金钻说明:打赏所获得的金钻不能二次打赏。";
    [self addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(36);
    }];
    
    
    UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(hintLabel.mas_bottom);
        make.height.mas_equalTo(MARGIN_10);
    }];
    
    
    UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    titleLabel.text = @"打赏排行榜";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *zuanLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    zuanLabel.text = @"金钻";
    [self addSubview:zuanLabel];
    [zuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 62 + 36 + MARGIN_10 + 40;
}

- (void)updateWithModel:(MyExceptionalModel *)model {
    self.receiveLabel.text = [NSString stringWithFormat:@"%@枚",model.gold?:@"0"];
    self.returnLabel.text = [NSString stringWithFormat:@"￥%@",model.price?:@"0"];
}

#pragma mark - action -

#pragma mark - getter -

@end
