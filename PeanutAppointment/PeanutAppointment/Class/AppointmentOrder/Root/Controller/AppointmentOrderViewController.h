//
//  AppointmentOrderViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum : NSUInteger {
    AppointmentOrderViewControllerType_Default,
    AppointmentOrderViewControllerType_ChooseType,//选择分类
} AppointmentOrderViewControllerType;

@interface AppointmentOrderViewController : BaseTableViewController

@property (nonatomic, assign) AppointmentOrderViewControllerType type;

@end
