//
//  PersonalAuthCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PersonalAuthCell.h"

@interface PersonalAuthCell()

@end

@implementation PersonalAuthCell

#pragma mark - lifeCycle -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {

    self.backgroundColor = COLOR_UI_FFFFFF;
    
    [self addSubview:self.imageV];
    [self addSubview:self.contentLabel];
    [self addSubview:self.statusLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imageV.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return 35;
}

#pragma mark - getter -

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    }
    return _contentLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
    }
    return _statusLabel;
}


@end
