//
//  MineCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MineCell.h"
#import "MineModel.h"

@interface MineCell()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MineCell

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
    
    __weak __typeof(self)weakSelf = self;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imageV.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf);
    }];
    
    UIImageView *nextImgV = [[UIImageView alloc] init];
    nextImgV.image = imageNamed(@"common_btn_next_more");
    [self addSubview:nextImgV];
    [nextImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -

- (void)setModel:(MineModel *)model {
    _model = model;
    
    self.imageV.image = imageNamed(model.icon);
    self.contentLabel.text = model.text;
}

+ (CGFloat)getCellHeight {
    
    return 55;
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

@end
