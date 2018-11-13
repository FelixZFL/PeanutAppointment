//
//  UserBaseInfoView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserBaseInfoView.h"

@interface UserBaseInfoView()


@end

@implementation UserBaseInfoView

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
    
    [self addSubview:self.headImageV];
    [self addSubview:self.typeLevelLabel];
    [self addSubview:self.distanceLabel];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.ageLabel];
    [self addSubview:self.genderLabel];
    [self addSubview:self.authimgLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.typeLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.top.equalTo(weakSelf.headImageV.mas_top);
//        make.right.equalTo(weakSelf.withdrawButton.mas_left).with.mas_offset(-MARGIN_5);
//        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf.typeLevelLabel.mas_centerY);
        make.left.equalTo(weakSelf.typeLevelLabel.mas_right);
//        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.bottom.equalTo(weakSelf.headImageV.mas_bottom);
        make.height.with.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nickNameLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.nickNameLabel.mas_centerY);
        make.height.with.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.ageLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.nickNameLabel.mas_centerY);
        make.height.with.mas_greaterThanOrEqualTo(0);
    }];
    
    [self.authimgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.genderLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.nickNameLabel.mas_centerY);
        make.height.with.mas_greaterThanOrEqualTo(0);
    }];
    
    
    [self setdata];

}

#pragma mark - public -

+ (CGFloat)getHeight {
    return 66;
}

- (void)setdata {
    //实现富文本
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
    
    for (int i = 0; i < 3; i++) {
        //进行图文混排
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        textAttachment.image = [UIImage imageNamed:@"mine_icon_vip"];
        textAttachment.bounds =CGRectMake(0,0, 16,16);
        NSAttributedString * textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
        [string insertAttributedString:textAttachmentString atIndex:string.length];
    }
    
    self.authimgLabel.attributedText = string;
}

#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)typeLevelLabel {
    if (!_typeLevelLabel) {
        _typeLevelLabel = [[UILabel alloc] init];
        [_typeLevelLabel setLabelFont:KFont(14) textColor:COLOR_UI_000000 textAlignment:NSTextAlignmentLeft];
        [_typeLevelLabel setTextString:@"瑜伽·初级" AndColorSubString:@"初级" color:COLOR_UI_THEME_RED];
    }
    return _typeLevelLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        [_distanceLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
        _distanceLabel.text = @"10KM";
    }
    return _distanceLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        [_nickNameLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _nickNameLabel.text = @"笑笑";
    }
    return _nickNameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        [_ageLabel setLabelFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _ageLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_ageLabel setDefaultCorner];
        _ageLabel.text = @"23岁";
    }
    return _ageLabel;
}

- (UILabel *)genderLabel {
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] init];
        [_genderLabel setLabelFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _genderLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_genderLabel setDefaultCorner];
        _genderLabel.text = @"男";
    }
    return _genderLabel;
}

- (UILabel *)authimgLabel {
    if (!_authimgLabel) {
        _authimgLabel = [[UILabel alloc] init];
        _authimgLabel.font = KFont(12);
    }
    return _authimgLabel;
}


@end
