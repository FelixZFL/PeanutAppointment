//
//  OrderManageListModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/7.
//  Copyright © 2018 felix. All rights reserved.
//

#import "OrderManageListModel.h"

@implementation OrderManageListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"invitedList":[OrderManageInvitedListModel class]};
}

@end

@implementation OrderManageInvitedListModel
@end
