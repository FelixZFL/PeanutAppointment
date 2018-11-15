//
//  UserMainPageFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserMainPageSkillInfoModel;

@interface UserMainPageFootView : UIView

@property (nonatomic, strong) UserMainPageSkillInfoModel *model;

+ (CGFloat )getHeightWithModel:(UserMainPageSkillInfoModel *)model;

@end
