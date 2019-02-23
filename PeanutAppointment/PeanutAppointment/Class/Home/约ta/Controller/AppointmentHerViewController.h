//
//  AppointmentHerViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/25.
//  Copyright © 2018年 felix. All rights reserved.
//  ------------------ 选好了应邀人   发布需求  约单------------------------------------------------------

#import "BaseTableViewController.h"

//1、（首页去约Ta）和（点击头像进入别人主页点击去约Ta）是传pusId、jnName；
//2、首页点击今日之星进入别人主页点击去约Ta不用传技能，这中情况是获取用户技能（这个技能是可选的，选择后下面的技能下面的内容都要变）；

@class HomeIndexUserModel;
@class UserMainPageUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface AppointmentHerViewController : BaseTableViewController

///
@property (nonatomic, strong) HomeIndexUserModel *choosedUser;


///用户id
@property (nonatomic, strong) NSString *yUserId;
///用户信息
@property (nonatomic, strong) UserMainPageUserInfoModel *userModel;


@end

NS_ASSUME_NONNULL_END
