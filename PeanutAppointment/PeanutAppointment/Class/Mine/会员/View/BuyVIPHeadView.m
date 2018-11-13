//
//  BuyVIPHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BuyVIPHeadView.h"
#import "BuyVIPModel.h"

#define kBtnTag 748

@interface BuyVIPHeadView()

@property (nonatomic, strong) UIView *btnView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BuyVIPHeadView

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
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = imageNamed(@"vip_top_bg");
    [self addSubview:imageV];
    
    CGFloat imageVHeight = SCREEN_WIDTH * 150/375.f;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    UIView *btnView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self addSubview:btnView];
    self.btnView = btnView;
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(imageV.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    
}

#pragma mark - public -
+ (CGFloat )getHeightWithArray:(NSArray <BuyVIPModel *>*)array {
    CGFloat imageVHeight = SCREEN_WIDTH * 150/375.f;
    if (array.count > 0) {
        CGFloat btnH = 50;
        NSInteger column = 3;
        CGFloat btnViewHeight = (btnH + MARGIN_15) * ceilf(array.count/(float)column);
        return imageVHeight + btnViewHeight;
    } else {
        return imageVHeight;
    }
}


- (void)updateWithArray:(NSArray <BuyVIPModel *>*)array {
    
    _dataArray = array;
    
    [self.btnView removeAllSubviews];
    NSInteger column = 3;
    
    CGFloat btnW = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_5 * (column + 1))/column;
    CGFloat btnH = 50;
    
    CGFloat btnViewHeight = (btnH + MARGIN_15) * ceilf(array.count /(float)column);
    
    [self.btnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(btnViewHeight);
    }];
    
    for (int i = 0; i < array.count; i++) {
        BuyVIPModel *model = array[i];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 + i%column * (btnW + MARGIN_5),MARGIN_15 + i/column * (btnH + MARGIN_15), btnW, btnH)];
        btn.titleLabel.font = KFont(14);
        [btn setTitle:[NSString stringWithFormat:@"%@%@元",model.dayNumber,model.price] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        btn.backgroundColor = COLOR_UI_FFFFFF;
        [btn setCorner:CORNER_2];
        [btn setborderColor:COLOR_UI_999999];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBtnTag + i;
        [self.btnView addSubview:btn];
    }
}

#pragma mark - action -

- (void)btnAction:(UIButton *)sender {
    for (UIButton *btn in self.btnView.subviews) {
        if (btn.tag == sender.tag) {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        } else {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        }
    }
    if (self.chooseBlock && self.dataArray.count > sender.tag - kBtnTag) {
        self.chooseBlock(self.dataArray[sender.tag - kBtnTag]);
    }
}

#pragma mark - getter -


@end
