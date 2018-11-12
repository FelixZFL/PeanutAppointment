//
//  MyMainPageModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyMainPageModel.h"

@implementation MyMainPageModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[MainPageVisitorModel class], @"info":[MyMainPageInfoModel class]};
}

@end

@implementation MainPageVisitorModel
@end

@implementation MyMainPageInfoModel
@end
