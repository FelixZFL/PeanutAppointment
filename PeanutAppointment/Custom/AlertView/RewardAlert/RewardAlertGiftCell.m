//
//  RewardAlertGiftCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RewardAlertGiftCell.h"

#import "RewardModel.h"

@interface RewardAlertGiftCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *diamondNumLabel;

@end

@implementation RewardAlertGiftCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        __weak __typeof(self)weakSelf = self;
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.equalTo(weakSelf.imageView.mas_width);
        }];
        
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(weakSelf.imageView.mas_bottom).with.mas_offset(MARGIN_5);
        }];
        
        [self addSubview:self.diamondNumLabel];
        [self.diamondNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-MARGIN_5);
        }];
        
    }
    return self;
}


#pragma mark - public -

- (void)setModel:(RewardGiftListModel *)model {
    _model = model;
    
//    [self.imageView sd_setImageWithURL:URLWithString(model) placeholderImage:imageNamed(@"common_placeholder")];
    self.nameLabel.text = model.pName;
    self.diamondNumLabel.text = [NSString stringWithFormat:@"%@个金钻",model.jzNumber];
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - getter -

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = imageNamed(@"common_placeholder");
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setLabelFont:KFont(10) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentCenter];
        _nameLabel.text = @"鲜花价值";
    }
    return _nameLabel;
}

- (UILabel *)diamondNumLabel {
    if (!_diamondNumLabel) {
        _diamondNumLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentCenter];
        _diamondNumLabel.text = @"50个金钻";
    }
    return _diamondNumLabel;
}


@end
