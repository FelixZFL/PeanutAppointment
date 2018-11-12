//
//  RechargeTypeCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RechargeTypeCell.h"

@implementation RechargeTypeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.typeImgV];
    [self.typeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typeImgV.mas_right).with.mas_offset(MARGIN_5);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.selectImgV];
    [self.selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
}

#pragma mark - public -
+ (CGFloat)getCellHeight {
    return 55;
}

#pragma mark - getter -

- (UIImageView *)typeImgV {
    if (!_typeImgV) {
        _typeImgV = [[UIImageView alloc] init];
        _typeImgV.image = imageNamed(@"payType_alipay");
    }
    return _typeImgV;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        [_typeLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _typeLabel.text = @"支付宝";
    }
    return _typeLabel;
}

- (UIImageView *)selectImgV {
    if (!_selectImgV) {
        _selectImgV = [[UIImageView alloc] init];
        _selectImgV.image = imageNamed(@"payType_unselect");//shoppingCart_select
    }
    return _selectImgV;
}

@end
