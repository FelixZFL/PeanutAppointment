//
//  MaJiangVipFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MaJiangVipFootView.h"
#import "MajiangVipModel.h"

#define kViewTag 7365

@interface MaJiangVipFootView()



@end

@implementation MaJiangVipFootView

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
    
    CGFloat viewWidth = (SCREEN_WIDTH - MARGIN_15 *3)/2.f;
    CGFloat viewHeight = 57;
    
    for (int i = 0; i < _dataArray.count; i++) {
        MajiangVipModel *model = _dataArray[i];
        
        UIView *view = [UIView viewWithColor:COLOR_UI_THEME_RED];
        [view setDefaultCorner];
        view.frame = CGRectMake(MARGIN_15 + i%2 * (viewWidth + MARGIN_15), MARGIN_15 + i/2 * (viewHeight + MARGIN_15), viewWidth, viewHeight);
        view.tag = kViewTag + i;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)]];
        [self addSubview:view];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.userInteractionEnabled = NO;
        [btn setImage:imageNamed(@"majiang_VIP") forState:UIControlStateNormal];
        [btn setImage:imageNamed(@"majiang_VIP") forState:UIControlStateHighlighted];
        [btn setButtonStateNormalTitle:[NSString stringWithFormat:@"%@天%@元",model.dayNumber,model.price] Font:KFont(17) textColor:COLOR_UI_FFFFFF];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.equalTo(view.mas_centerY).with.mas_offset(3);
        }];
        
        UILabel *label = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
        label.text = [NSString stringWithFormat:@"送%@张房卡",model.roomCardNumber?:@"0"];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(btn.mas_bottom);
        }];
        
    }
    
}

#pragma mark - public -

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self setupUI];
}

+ (CGFloat )getHeightWithDadaArray:(NSArray *)dataArray {
    
    return MARGIN_15 + ceil(dataArray.count/2.f) * (MARGIN_15 + 57)  + MARGIN_15;
}

#pragma mark - action -

- (void)itemClick:(UITapGestureRecognizer *)tapGes {
    NSInteger index = tapGes.view.tag - kViewTag;
    if (self.itemClickBlock && self.dataArray.count > index) {
        self.itemClickBlock(self.dataArray[index]);
    }
}


@end
