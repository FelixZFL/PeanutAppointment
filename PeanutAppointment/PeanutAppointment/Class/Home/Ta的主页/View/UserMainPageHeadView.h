//
//  UserMainPageHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserMainPageModel;

@interface UserMainPageHeadView : UIView

@property (nonatomic, copy) void(^skillClickBlock)(NSString *pusId);

@property (nonatomic, strong) UserMainPageModel *model;

+ (CGFloat )getHeightWithModel:(UserMainPageModel *)model;

@end

