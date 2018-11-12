//
//  TitleImageButton.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "TitleImageButton.h"

@implementation TitleImageButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        __weak __typeof(self)weakSelf = self;
        
        self.userInteractionEnabled = NO;
        
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.width.mas_greaterThanOrEqualTo(0);
        }];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.imageView.mas_left).with.mas_offset(-MARGIN_5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_greaterThanOrEqualTo(0);
            make.left.mas_equalTo(0);
        }];
        
    }
    return self;
}

#pragma mark - public -
+ (instancetype) buttonWithTitle:(NSString *)title {
    return [TitleImageButton buttonWithTitle:title Font:KFont(12) titleColor:COLOR_UI_999999 image:imageNamed(@"common_btn_next_more")];
}

+ (instancetype) buttonWithTitle:(NSString *)title Font:(UIFont *)font titleColor:(UIColor *)color image:(UIImage *)image {
    
    TitleImageButton *btn = [[TitleImageButton alloc] init];
    [btn setButtonStateNormalTitle:title Font:font textColor:color];
    btn.imageView.image = image;
    return btn;
}


- (void)setButtonStateNormalTitle:(NSString *)title Font:(UIFont *)font textColor:(UIColor*)color {
    [self.titleLabel setLabelFont:font textColor:color textAlignment:NSTextAlignmentLeft];
    self.titleLabel.text = title;
}

- (void)setTitle:(NSString *)title Image:(UIImage *)image {
    self.titleLabel.text = title;
    self.imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - getter -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}


@end
