//
//  MyExceptionalModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyExceptionalModel.h"

@implementation MyExceptionalModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":[MyExceptionalListModel class]};
}

@end
