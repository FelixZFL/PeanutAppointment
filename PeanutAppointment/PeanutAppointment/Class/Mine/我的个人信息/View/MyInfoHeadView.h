//
//  MyInfoHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoHeadView : UIView

@property (nonatomic, strong) UIImageView *headImageV;

+ (CGFloat )getHeight;

- (void)updateWithModel:(UserInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
