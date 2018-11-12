//
//  PhotoAlbumSectionHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbumSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;


+ (NSString *) reuseIdentifier;

+ (CGFloat)getHeight;

@end

NS_ASSUME_NONNULL_END
