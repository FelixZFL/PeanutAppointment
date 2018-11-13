//
//  MyInfoHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyInfoHeadView.h"

#import "UserInfoModel.h"

@interface MyInfoHeadView()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation MyInfoHeadView

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
    
    [self addSubview:self.headImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.hintLabel];
    
    __weak __typeof(self)weakSelf = self;
    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.headImageV);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.headImageV.mas_centerY);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 65 + MARGIN_10;
}

- (void)updateWithModel:(UserInfoModel *)model {
    
    [_headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
//    _nameLabel.text = [NSString stringWithFormat:@"%@（点击图片修改）",model.nikeName];
}

#pragma mark - action -

#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _nameLabel.text = @"头像（点击图片修改）";
    }
    return _nameLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel setLabelFont:KFont(10) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _hintLabel.text = @"温馨提示：更换头像将导致您的技能重新被审核";
    }
    return _hintLabel;
}


@end
