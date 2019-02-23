//
//  MaJiangRoomCardFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MaJiangRoomCardFootView.h"
#import "MajiangRoomCardModel.h"

#define kImageTag 7438

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
        MajiangRoomCardModel *model = _dataArray[i];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:imageNamed(@"majiang_roomCard")];
        view.frame = CGRectMake(i%2 == 0 ? MARGIN_15 : SCREEN_WIDTH - viewWidth - MARGIN_15, MARGIN_15 + i/2 * (viewHeight + MARGIN_15), viewWidth, viewHeight);
        view.tag = kImageTag + i;
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)]];
        [self addSubview:view];
        
        UILabel *moneyLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentRight];
        moneyLabel.text = [NSString stringWithFormat:@"￥%@元",model.price];
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-MARGIN_15);
            make.centerY.equalTo(view.mas_centerY);
        }];
        
        UILabel *label = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        label.text = [NSString stringWithFormat:@"%@张房卡",model.roomCardNumber];
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

- (void)itemClick:(UITapGestureRecognizer *)tapGes {
    NSInteger index = tapGes.view.tag - kImageTag;
    if (self.itemClickBlock && self.dataArray.count > index) {
        self.itemClickBlock(self.dataArray[index]);
    }
}


@end
