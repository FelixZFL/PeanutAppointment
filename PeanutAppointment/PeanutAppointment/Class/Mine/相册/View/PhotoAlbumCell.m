//
//  PhotoAlbumCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PhotoAlbumCell.h"

#import "PhotoAlbumPhotosModel.h"

#define kImgVtag 46532

@interface PhotoAlbumCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PhotoAlbumCell

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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
}

#pragma mark - public -
+ (CGFloat)getCellHeightWithModel:(PhotoAlbumPhotosModel *)model {
    NSArray *array = [model.photosUrl componentsSeparatedByString:@","];
    if (array.count > 0) {
        CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
        return 35 + (photoWidth + MARGIN_1)* ((array.count - 1)/3 + 1) + MARGIN_10;
    } else {
        return 35;
    }
    
}

- (void)setModel:(PhotoAlbumPhotosModel *)model {
    _model = model;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@·%@",model.photoTime,model.typeName];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *array = [model.photosUrl componentsSeparatedByString:@","];
    if (array.count > 0) {
        CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
        for (int i = 0; i < array.count; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_15 + i%3 * (photoWidth + MARGIN_1), 35 + i/3 * (photoWidth + MARGIN_1), photoWidth, photoWidth)];
            imageV.tag = kImgVtag + i;
            imageV.userInteractionEnabled = YES;
            [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)]];
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            imageV.clipsToBounds = YES;
            [imageV sd_setImageWithURL:URLWithString(array[i])];
            [self addSubview:imageV];
        }
    }
}

#pragma mark - action -

- (void)imageTapAction:(UITapGestureRecognizer *)tapGest {
    
    NSInteger index = tapGest.view.tag - kImgVtag;
    NSArray *array = [_model.photosUrl componentsSeparatedByString:@","];
    
    if (self.photoClickBlock && array.count > index) {
        self.photoClickBlock(self.model, index);
    }
}

#pragma mark - getter -

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = @"05 7月·逛街";
    }
    return _titleLabel;
}

@end
