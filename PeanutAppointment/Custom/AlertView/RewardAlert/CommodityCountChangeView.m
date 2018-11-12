//
//  CommodityCountChangeView.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CommodityCountChangeView.h"

@interface CommodityCountChangeView()

@property (nonatomic, strong) UILabel *countLabel;


@end


@implementation CommodityCountChangeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _maxNum = 999999999;
        _currentNum = 1;
        
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    __weak __typeof(self)weakSelf = self;
    
    CGFloat btnWidth = 26;
    CGFloat btnHeight = CommodityCountChangeViewHeight;
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setButtonStateNormalTitle:@"+" Font:KFont(14) textColor:COLOR_UI_222222];
    [addBtn setborderColor:COLOR_UI_999999];
    [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left).with.mas_offset(LINE_HEIGHT);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(btnHeight);
        make.width.mas_greaterThanOrEqualTo(0);
    }];
    
    UIButton *minusBtn = [[UIButton alloc] init];
    [minusBtn setButtonStateNormalTitle:@"-" Font:KFont(14) textColor:COLOR_UI_666666];
    [minusBtn setborderColor:COLOR_UI_999999 ];
    [minusBtn addTarget:self action:@selector(minusBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusBtn];
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.countLabel.mas_left).with.mas_offset(LINE_HEIGHT);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_equalTo(btnWidth);
        make.height.mas_equalTo(btnHeight);
    }];
}

#pragma mark - public -

- (void)setMaxNum:(NSInteger)maxNum {
    _maxNum = maxNum;
    if (self.currentNum > maxNum) {
        self.currentNum = maxNum;
    }
}

- (void)setCurrentNum:(NSInteger)currentNum {
    if (currentNum < 1) {
        _currentNum = 1;
    }else if (currentNum > _maxNum) {
        _currentNum = _maxNum;
    }else {
        _currentNum = currentNum;
    }
    
    
    self.countLabel.text = [NSString stringWithFormat:@"  %ld  ",(long)_currentNum];
}

#pragma mark - action -
- (void)addBtnAction {
    NSLog(@"++++");
    self.currentNum = self.currentNum + 1;
    if (self.chooseNumChangedBlock) {
        self.chooseNumChangedBlock(self.currentNum,CountChangeType_Add);
    }
}

- (void)minusBtnAction {
    NSLog(@"-----");
    self.currentNum = self.currentNum - 1;
    if (self.chooseNumChangedBlock) {
        self.chooseNumChangedBlock(self.currentNum,CountChangeType_Minus);
    }
}


#pragma mark - getter -

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        [_countLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        [_countLabel setborderColor:COLOR_UI_999999 ];
        _countLabel.text = [NSString stringWithFormat:@"  %ld  ",(long)_currentNum];
    }
    return _countLabel;
}

@end
