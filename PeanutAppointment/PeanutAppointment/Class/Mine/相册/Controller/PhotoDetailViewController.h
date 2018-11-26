//
//  PhotoDetailViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/27.
//  Copyright © 2018 felix. All rights reserved.
//

#import "BaseViewController.h"

@class PhotoAlbumPhotosModel;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDetailViewController : BaseViewController

@property (nonatomic, strong) PhotoAlbumPhotosModel *photoModel;

@property (nonatomic, assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
