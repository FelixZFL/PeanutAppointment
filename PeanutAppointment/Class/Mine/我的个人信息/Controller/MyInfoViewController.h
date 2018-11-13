//
//  MyInfoViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

@class UserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoViewController : BaseTableViewController

@property (nonatomic, strong) UserInfoModel *model;

@end

NS_ASSUME_NONNULL_END
