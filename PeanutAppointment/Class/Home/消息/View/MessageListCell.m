//
//  MessageListCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MessageListCell.h"

#import "MessageModel.h"

@interface MessageListCell()

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *badgeLabel;//红点

@end

@implementation MessageListCell

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
    
    [self addSubview:self.headImageV];
    [self addSubview:self.namelabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.badgeLabel];

    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.width.height.mas_equalTo(45);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.right.equalTo(weakSelf.badgeLabel.mas_left);
        make.top.mas_equalTo(MARGIN_15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.right.equalTo(weakSelf.badgeLabel.mas_left);
        make.bottom.mas_equalTo(-MARGIN_15);
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
    
    return 70;
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    
    
}

#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)namelabel {
    if (!_namelabel) {
        _namelabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _namelabel.text = @"笑笑·30岁";
    }
    return _namelabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _contentLabel.text = @"手动阀十分好撒旦反萨地方阿三的风口浪······";
    }
    return _contentLabel;
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
