//
//  HomeActivityView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeActivityView : UIView

@property (nonatomic, copy) void(^imageTapAction) (NSInteger index);

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
