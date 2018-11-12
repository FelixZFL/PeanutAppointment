//
//  UserBaseInfoView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserBaseInfoView : UIView


@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *typeLevelLabel;//类型 等级
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *authimgLabel;//认证图标


+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
