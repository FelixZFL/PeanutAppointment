//
//  AddPhotoAlbumHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChooseTagView.h"

@class PhotoTypeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface AddPhotoAlbumHeadView : UIView

@property (nonatomic, strong) ChooseTagView *tagView;

@property (nonatomic, strong) NSArray<PhotoTypeListModel *> *tagArray;

+ (CGFloat )getHeightwithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
