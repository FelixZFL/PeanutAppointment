//
//  ReleaseOrderFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ReleaseOrderFootView.h"

#import "ReleaseOrderUserModel.h"

#define kBtnTag 893

@interface ReleaseOrderFootView()

@end

@implementation ReleaseOrderFootView

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
    titleLabel.text = @"您已选择";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeightWithArray:(NSArray *)array {
    if (array.count < 1) {
        return 0;
    }
    
    CGFloat marginLeft = 60 + MARGIN_15 * 2;
    CGFloat btnWidth = 30;
    NSInteger lineCount = floorf((SCREEN_WIDTH - marginLeft - MARGIN_15 + MARGIN_5)/(btnWidth + MARGIN_5));
    CGFloat height =  MARGIN_10 + ((array.count -1)/lineCount + 1) * (btnWidth + MARGIN_5) + MARGIN_10;
    
    return  height;
}

- (void)setArray:(NSArray<ReleaseOrderUserModel *> *)array {
    _array = array;
    
    //删除所有按钮
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat marginLeft = 60 + MARGIN_15 * 2;
    CGFloat btnWidth = 30;
    NSInteger lineCount = floorf((SCREEN_WIDTH - marginLeft - MARGIN_15 + MARGIN_5)/(btnWidth + MARGIN_5));
    
    for (int i = 0; i < array.count; i++) {
        ReleaseOrderUserModel *user = array[i];
        UIButton *btn = [[UIButton alloc] init];
        [btn sd_setImageWithURL:URLWithString(user.headUrl) forState:UIControlStateNormal placeholderImage:imageNamed(placeHolderHeadImageName)];
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBtnTag + i;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft + i%lineCount * (btnWidth + MARGIN_5));
            make.top.mas_equalTo(MARGIN_10 + i/lineCount * (btnWidth + MARGIN_5));
            make.width.height.mas_equalTo(btnWidth);
        }];
    }
    
}

- (void)btnClickAction:(UIButton *)sender {
    if (self.btnClickBlcok) {
        self.btnClickBlcok(sender.tag = kBtnTag);
    }
}

#pragma mark - getter -


@end
