//
//  AddPhotoAlbumFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddPhotoAlbumFootView.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define kImageTag 57489

@interface AddPhotoAlbumFootView()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *photoView;

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, assign) NSInteger maxPhotoCount;

@end

@implementation AddPhotoAlbumFootView

#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        _maxPhotoCount = 9;
        [self setupUI];
    }
    return self;
    
}
#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(60);
    }];
    titleLabel.text = @"上传图片";
    [titleLabel changeAligmentRightAndLeftWithWidth:60];
    self.titleLabel = titleLabel;
    
    UILabel *contentLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_999999 textAlignment:NSTextAlignmentLeft];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    contentLabel.text = @"请上传描述该技能相关得图片";
    self.contentLabel = contentLabel;
    
    
    UIView *photoView = [[UIView alloc] init];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(0);
    }];
    self.photoView = photoView;
    
    [self updatePhotoView];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    CGFloat photoWith = (SCREEN_WIDTH - MARGIN_15 *5 - 60)/3.f;

    return 35 + photoWith;
}

#pragma mark - private

- (void)updatePhotoView {
    
    [self.photoView removeAllSubviews];
    
    CGFloat photoWith = (SCREEN_WIDTH - MARGIN_15 *5 - 60)/3.f;
    
    
    
    NSInteger repeatCount = self.photos.count >= _maxPhotoCount ? _maxPhotoCount : self.photos.count + 1;
    
    for (int i = 0; i < repeatCount; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i%3 * (photoWith + MARGIN_15), i/3 * (photoWith + MARGIN_15), photoWith, photoWith)];
        imageV.userInteractionEnabled = YES;
        imageV.tag = kImageTag + i;
        
        if (self.photos.count > i) {
            imageV.backgroundColor = COLOR_UI_000000;
            imageV.image = self.photos[i];
            [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)]];
        } else {
            imageV.backgroundColor = COLOR_UI_F0F0F0;
            imageV.image = imageNamed(@"common_btn_addPhoto");
            [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageTapAction:)]];
        }
        [self.photoView addSubview:imageV];
    }
    CGFloat height = 35 + ((repeatCount - 1)/3 + 1) * (photoWith + MARGIN_15);
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    if (self.heightChangeBlock) {
        self.heightChangeBlock(height);
    }
}

#pragma mark - action -

- (void)imageTapAction:(UITapGestureRecognizer *)tap {
    UIImageView *imageV = (UIImageView *)tap.view;
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithSelectedAssets:self.assets selectedPhotos:self.photos index:imageV.tag - kImageTag];
    [self.topViewController presentViewController:imagePickerVC animated:YES completion:nil];
    
}
- (void)addImageTapAction:(UITapGestureRecognizer *)tap {
    
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxPhotoCount - self.photos.count delegate:self];
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.assets addObjectsFromArray:assets];
        [self.photos addObjectsFromArray:photos];
        [self updatePhotoView];
    }];
    [self.topViewController presentViewController:imagePickerVC animated:YES completion:nil];
    
}

#pragma mark - getter -

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray arrayWithCapacity:1];
    }
    return _photos;
}

- (NSMutableArray *)assets {
    if (!_assets) {
        _assets = [NSMutableArray arrayWithCapacity:1];
    }
    return _assets;
}

@end
