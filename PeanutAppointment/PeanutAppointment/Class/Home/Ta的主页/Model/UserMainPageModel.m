//
//  UserMainPageModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import "UserMainPageModel.h"

@implementation UserMainPageModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"userInfo":[UserMainPageUserInfoModel class],
             @"phontList":[UserMainPagePhotoListModel class],
             @"skillList":[UserMainPageSkillListModel class],
             @"skillInfo":[UserMainPageSkillInfoModel class],
             @"accessList":[UserMainPageAccessListModel class]};
}

@end

@implementation UserMainPageUserInfoModel
@end
@implementation UserMainPagePhotoListModel
@end
@implementation UserMainPageSkillListModel
@end
@implementation UserMainPageSkillInfoModel
@end
@implementation UserMainPageAccessListModel
@end
