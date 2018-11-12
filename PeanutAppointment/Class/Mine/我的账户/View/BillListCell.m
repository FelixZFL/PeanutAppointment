//
//  BillListCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BillListCell.h"

#import "BillListModel.h"

@interface BillListCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation BillListCell

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
    
    [self addSubview:self.moneyLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.right.lessThanOrEqualTo(weakSelf.moneyLabel.mas_left);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.bottom.mas_equalTo(-MARGIN_10);
        make.right.lessThanOrEqualTo(weakSelf.moneyLabel.mas_left);
    }];
    
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return 55;
}

- (void)setModel:(BillListModel *)model {
    _model = model;
    
    self.nameLabel.text = model.content;
    self.timeLabel.text = model.createTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@%@",[model.ptype integerValue] == 2 ? @"-" : @"+",model.price];

}

#pragma mark - getter -

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setLabelFont:KFont(12) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _nameLabel.text = @"buzdao向你付款";
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _timeLabel.text = @"2018-08-23";
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        [_moneyLabel setLabelFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentRight];
        _moneyLabel.text = @"0.00";
    }
    return _moneyLabel;
}

@end
