//
//  MyPeanutsSingleCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyPeanutsSingleCell.h"

#import "MyPeanutsListModel.h"

@interface MyPeanutsSingleCell()


@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *authImageV1;
@property (nonatomic, strong) UIImageView *authImageV2;

@end

@implementation MyPeanutsSingleCell

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
    
    [self addSubview:self.headImageV];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.top.equalTo(weakSelf.headImageV.mas_top);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf.nameLabel);
    }];
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10 + i * (19 + 2));
            make.bottom.equalTo(weakSelf.headImageV.mas_bottom).with.mas_offset(-4);
            make.size.mas_equalTo(CGSizeMake(19, 19));
        }];
        
        if (i == 0) {
            imageV.image = imageNamed(@"myPeanuts_auth_person_small");
            self.authImageV1 = imageV;
        } else {
            imageV.image = imageNamed(@"myPeanuts_auth_skill_smasll");
            self.authImageV2 = imageV;
        }
    }
    
}

#pragma mark - public -

- (void)setModel:(MyFansModel *)model {
    _model = model;
    
    [self.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.nameLabel.text = model.nikeName;
    self.timeLabel.text = model.regTime;
    self.authImageV1.hidden = [model.idCard integerValue] != 1;
    self.authImageV2.hidden = [model.isCertification integerValue] != 1;
    
}

+ (CGFloat)getCellHeight {
    
    return 50;
}

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
        _nameLabel.text = @"昵称";
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
        _timeLabel.text = @"2018-08-23";
    }
    return _timeLabel;
}


@end
