//
//  UserMainPageViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

@class HomeIndexUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserMainPageViewController : BaseTableViewController

///用户id
@property (nonatomic, copy) NSString *userId;

///技能id
//@property (nonatomic, copy) NSString *pusId;

///用户信息
@property (nonatomic, strong) HomeIndexUserModel *userModel;


@end

NS_ASSUME_NONNULL_END
