//
//  HomeSortAlertView.m
//  PeanutAppointment
//
//  Created by felix on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import "HomeSortAlertView.h"

#define  SortAlertViewHeight 128

#define kBtnTag 5445

@interface HomeSortAlertView()

@property (nonatomic, copy) ChooseIndexBlock chooseBlock;

@property (nonatomic, strong) UIView *layerView;

@end

@implementation HomeSortAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    
    NSArray *btnArr = @[@"智能排序",@"接单最多",@"距离最近"];
    
    CGFloat btnWidth = 80;
    
    for (int i = 0; i < btnArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 + i * (btnWidth + MARGIN_10), MARGIN_15, btnWidth, 30)];
        [btn setButtonStateNormalTitle:btnArr[i] Font:KFont(12) textColor:COLOR_UI_666666];
        [btn setborderColor:COLOR_UI_999999];
        [btn setDefaultCorner];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.2);
    [self.layerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removFromWindow)]];
    [window addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [window addSubview:self];
    self.y = window.height - SortAlertViewHeight;
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithBlock:(ChooseIndexBlock)block {
    HomeSortAlertView *alert = [[HomeSortAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SortAlertViewHeight)];
    alert.chooseBlock = block;
    return alert;
}

#pragma mark - action -


- (void)btnClickAction:(UIButton *)sender {
    
    if (self.chooseBlock) {
        self.chooseBlock(sender.tag - kBtnTag);
    }
    
    [self removFromWindow];
}

@end
