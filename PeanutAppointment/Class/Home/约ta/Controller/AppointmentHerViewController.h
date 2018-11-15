//
//  AppointmentHerViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/25.
//  Copyright © 2018年 felix. All rights reserved.
//  ------------------ 选好了应邀人   发布需求  约单------------------------------------------------------

#import "BaseTableViewController.h"

@class HomeIndexUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentHerViewController : BaseTableViewController

@property (nonatomic, strong) HomeIndexUserModel *choosedUser;

@end

NS_ASSUME_NONNULL_END
