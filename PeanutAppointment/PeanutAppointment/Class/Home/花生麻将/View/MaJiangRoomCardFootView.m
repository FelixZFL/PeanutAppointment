//
//  MaJiangRoomCardFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MaJiangRoomCardFootView.h"

@interface MaJiangRoomCardFootView()

@end

@implementation MaJiangRoomCardFootView

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
    
    [self removeAllSubviews];
    
    CGFloat viewWidth = 150;
    CGFloat viewHeight = 60;
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        UIImageView *view = [[UIImageView alloc] initWithImage:imageNamed(@"majiang_roomCard")];
        view.frame = CGRectMake(i%2 == 0 ? MARGIN_15 : SCREEN_WIDTH - viewWidth - MARGIN_15, MARGIN_15 + i/2 * (viewHeight + MARGIN_15), viewWidth, viewHeight);
        view.userInteractionEnabled = YES;
        
        [self addSubview:view];
        
        UILabel *moneyLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentRight];
        moneyLabel.text = @"￥100元";
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-MARGIN_15);
            make.centerY.equalTo(view.mas_centerY);
        }];
        
        UILabel *label = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        label.text = @"55张房卡";
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_10);
            make.bottom.mas_equalTo(-MARGIN_5);
        }];
        
    }
    
}

#pragma mark - public -

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self setupUI];
}

+ (CGFloat )getHeightWithDadaArray:(NSArray *)dataArray {
    
    return MARGIN_15 + ceil(dataArray.count/2.f) * (MARGIN_15 + 60) + MARGIN_15 ;
}

#pragma mark - action -


@end
