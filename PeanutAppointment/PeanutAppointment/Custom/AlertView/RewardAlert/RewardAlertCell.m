//
//  RewardAlertCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RewardAlertCell.h"

#import "RewardModel.h"

@interface RewardAlertCell()

@property (nonatomic, strong) RewardRankingModel *model;

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *diamondNumLabel;

@end

@implementation RewardAlertCell

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
    [self addSubview:self.diamondNumLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
    
    [self.headImageV setCorner:30/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.numLabel.mas_right);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.diamondNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    UIImageView *diamondImgV = [[UIImageView alloc] init];
    diamondImgV.backgroundColor = COLOR_UI_THEME_RED;
    [self addSubview:diamondImgV];
    [diamondImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.diamondNumLabel.mas_left).with.mas_offset(-MARGIN_5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -
- (void)setModel:(RewardRankingModel * _Nonnull)model index:(NSInteger )index {
    _model = model;
    
    self.numLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
    [self.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.nameLabel.text = model.nikeName;
    self.diamondNumLabel.text = model.jzNumber;
    
}

+ (CGFloat)getCellHeight {
    
    return 50;
}

#pragma mark - getter -

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel labelWithFont:KFont(35) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
        _numLabel.text = @"2";
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
        _nameLabel.text = @"就看到";
    }
    return _nameLabel;
}

- (UILabel *)diamondNumLabel {
    if (!_diamondNumLabel) {
        _diamondNumLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentRight];
        _diamondNumLabel.text = @"47875";
    }
    return _diamondNumLabel;
}

@end
