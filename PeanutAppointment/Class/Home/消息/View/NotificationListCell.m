//
//  NotificationListCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "NotificationListCell.h"

#import "SystemMessageModel.h"

@interface NotificationListCell()

@property (nonatomic, strong) UILabel *titleLbael;

@property (nonatomic, strong) UILabel *badgeLabel;//红点

@end

@implementation NotificationListCell

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
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.titleLbael];
    [self addSubview:self.badgeLabel];
    
    [self.titleLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.equalTo(weakSelf.badgeLabel.mas_left);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
        make.width.height.mas_equalTo(14);
    }];
    
    self.badgeLabel.text = @"143";
    CGSize size = [@"143" sizeWithAttributes:@{NSFontAttributeName:KFont(9)}];
    if (size.width + MARGIN_5 > 14) {
        [self.badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width + MARGIN_5);
        }];
    }
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return 40;
}

- (void)setModel:(SystemMessageModel *)model {
    _model = model;
    
    self.titleLbael.text = model.titles;
}

#pragma mark - getter -

- (UILabel *)titleLbael {
    if (!_titleLbael) {
        _titleLbael = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _titleLbael.text = @"系统通知";
    }
    return _titleLbael;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [UILabel labelWithFont:KFont(9) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
        _badgeLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_badgeLabel setCorner:14/2.f];
    }
    return _badgeLabel;
}

@end
