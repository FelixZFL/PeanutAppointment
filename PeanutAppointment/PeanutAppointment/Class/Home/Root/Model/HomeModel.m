//
//  HomeModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/4.
//  Copyright © 2018 felix. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"banner":[HomeBannerModel class],
             @"gamePhotos":[HomeGamesModel class],
             @"toDayHotUser":[HomeHotUserModel class],
             @"toDayVideoHotUser":[HomeVideoHotUserModel class],
             @"indexUser":[HomeIndexUserModel class],
             @"tools":[HomeToolModel class],
             @"typeList":[HomeTypeListModel class],
             @"notice":[HomeNoticeListModel class] };
}

@end

@implementation HomeBannerModel
@end

@implementation HomeGamesModel
@end

@implementation HomeHotUserModel
@end

@implementation HomeVideoHotUserModel
@end

@implementation HomeToolModel
@end

@implementation HomeTypeListModel
@end

@implementation HomeNoticeListModel
@end


