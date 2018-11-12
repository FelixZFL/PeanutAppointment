//
//  MaJiangHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/14.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MaJiangHeadView.h"


@interface MaJiangHeadView()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@end


@implementation MaJiangHeadView

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
    
    __weak __typeof(self)weakSelf = self;
    
    CGFloat imageVHeight = SCREEN_WIDTH * 200/375.f;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = imageNamed(@"home_advertising_majiang");
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(imageV.mas_bottom).with.mas_offset(MARGIN_10);
    }];
    
    [self addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).with.mas_offset(MARGIN_10);
    }];
}

#pragma mark - public -

- (void)setContentStr:(NSString *)contentStr hintStr:(NSString *)hintStr {
    self.contentLabel.text = contentStr;
    self.hintLabel.text = hintStr;
}

+ (CGFloat)getHeightWithContentStr:(NSString *)contentStr hintStr:(NSString *)hintStr{
    CGFloat imageVHeight = SCREEN_WIDTH * 200/375.f;
    CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - MARGIN_15 * 2 font:KFont(12)];
    CGFloat hintHeight = [hintStr getHeightWithMaxWidth:SCREEN_WIDTH - MARGIN_15 * 2 font:KFont(12)];
    return imageVHeight + MARGIN_10 + contentHeight + MARGIN_10 + hintHeight + MARGIN_10;
}


#pragma mark - action -

#pragma mark - getter -

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel  setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel  setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _hintLabel.numberOfLines = 0;
    }
    return _hintLabel;
}

@end
