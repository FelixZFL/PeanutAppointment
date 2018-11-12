//
//  RebateRankingCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RebateRankingCell.h"

#import "RebateRankingModel.h"

@interface RebateRankingCell()

@property (nonatomic, strong) RebateRankingModel *model;

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation RebateRankingCell

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
    
    [self addSubview:self.numLabel];
    [self addSubview:self.headImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.moneyLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
    
    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.top.equalTo(weakSelf.headImageV);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.bottom.equalTo(weakSelf.headImageV);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -
- (void)setModel:(RebateRankingModel * _Nonnull)model index:(NSInteger )index {
    _model = model;
    
    self.numLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
    [self.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.nameLabel.text = model.nikeName;
    self.timeLabel.text = model.regTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}

+ (CGFloat)getCellHeight {
    
    return 66;
}

#pragma mark - getter -

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel labelWithFont:KFont(35) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
    }
    return _numLabel;
}

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}


- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentRight];
    }
    return _moneyLabel;
}


@end
