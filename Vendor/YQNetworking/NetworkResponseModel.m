//
//  NetworkResponseModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import "NetworkResponseModel.h"

@implementation NetworkResponseModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"version": [VersionModel class]};
}

@end
