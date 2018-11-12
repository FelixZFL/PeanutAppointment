//
//  PlaceholderView.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/27.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PlaceholderView.h"

@interface PlaceholderView()

@property (nonatomic, strong) UIImageView *noDataImageV;//无数据图片
@property (nonatomic, strong) UILabel *noDataLabel;//无数据提示


@end

@implementation PlaceholderView


#pragma mark - lifeCycle
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
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.noDataImageV];
    [self.noDataImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf.mas_centerY).with.mas_offset(-50);
    }];
    
    [self addSubview:self.noDataLabel];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.noDataImageV.mas_bottom).with.mas_offset(MARGIN_10);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
}

#pragma mark - getter

- (UIImageView *)noDataImageV {
    if (!_noDataImageV) {
        _noDataImageV = [[UIImageView alloc] initWithImage:imageNamed(@"nodata_icon")];
    }
    return _noDataImageV;
}

- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        [_noDataLabel setLabelFont:KFont(17) textColor:COLOR_UI_999999 textAlignment:NSTextAlignmentCenter];
        _noDataLabel.text = @"暂无数据";
    }
    return _noDataLabel;
}


@end
