//
//  RechargeAlertCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RechargeAlertCell.h"

#import "RechargeAlertListModel.h"

@interface RechargeAlertCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *diamondCountLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation RechargeAlertCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setDefaultCorner];
        [self setborderColor:COLOR_UI_999999];
        
        [self addSubview:self.imageV];
        [self addSubview:self.diamondCountLabel];
        [self addSubview:self.moneyLabel];
        
        __weak __typeof(self)weakSelf = self;
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_centerY).with.mas_offset(-MARGIN_5);
        }];
        
        [self.diamondCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(weakSelf.mas_centerY).with.mas_offset(MARGIN_5);
        }];
        
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(weakSelf.diamondCountLabel.mas_bottom).with.mas_offset(MARGIN_10);
        }];
    }
    return self;
}

#pragma mark - public -

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setModel:(RechargeAlertListModel *)model {
    _model = model;
    
    self.diamondCountLabel.text = [NSString stringWithFormat:@"%@钻",model.jzNumber];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.rmb];
}

#pragma mark - getter -

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithImage:imageNamed(@"rechargeAlert_diamond")];
    }
    return _imageV;
}

- (UILabel *)diamondCountLabel {
    if (!_diamondCountLabel) {
        _diamondCountLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentCenter];
        _diamondCountLabel.text = @"100钻";
    }
    return _diamondCountLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentCenter];
        _moneyLabel.text = @"20元";
    }
    return _moneyLabel;
}

@end
