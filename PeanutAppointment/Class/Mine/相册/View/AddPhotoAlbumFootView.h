//
//  AddPhotoAlbumFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddPhotoAlbumFootView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
///选择的图片数组
@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic, copy) void(^heightChangeBlock)(CGFloat height);

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
