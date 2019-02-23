//
//  PhotoAlbumSectionHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PhotoAlbumSectionHeadView.h"

@interface PhotoAlbumSectionHeadView()

@end

@implementation PhotoAlbumSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -

- (void)setupUI {
    
    self.contentView.backgroundColor = COLOR_UI_F0F0F0;
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - public -

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)getHeight {
    return 30;
}

#pragma mark - getter -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = @"2018年";
    }
    return _titleLabel;
}

@end
