//
//  PhotoAlbumCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class PhotoAlbumPhotosModel;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbumCell : BaseTableViewCell

@property (nonatomic, copy) void(^photoClickBlock)(PhotoAlbumPhotosModel *model, NSInteger index);

@property (nonatomic, strong) PhotoAlbumPhotosModel *model;

+ (CGFloat)getCellHeightWithModel:(PhotoAlbumPhotosModel *)model;

@end

NS_ASSUME_NONNULL_END
