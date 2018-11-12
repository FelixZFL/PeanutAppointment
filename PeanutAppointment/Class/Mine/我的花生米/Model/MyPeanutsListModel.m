//
//  MyPeanutsListModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyPeanutsListModel.h"

@implementation MyPeanutsListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"fansList":[MyFansModel class]};
}

@end

@implementation MyFansModel

@end
