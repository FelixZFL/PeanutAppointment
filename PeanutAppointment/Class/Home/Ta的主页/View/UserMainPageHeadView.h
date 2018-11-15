//
//  UserMainPageHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserMainPageModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserMainPageHeadView : UIView

@property (nonatomic, strong) UserMainPageModel *model;

+ (CGFloat )getHeightWithModel:(UserMainPageModel *)model;

@end

NS_ASSUME_NONNULL_END
