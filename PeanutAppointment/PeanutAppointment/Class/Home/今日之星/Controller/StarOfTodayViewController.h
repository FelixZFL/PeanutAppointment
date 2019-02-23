//
//  StarOfTodayViewController.h
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseViewController.h"

@class HomeIndexUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface StarOfTodayViewController : BaseViewController

@property (nonatomic, strong) HomeIndexUserModel *model;

@property (nonatomic, assign) NSInteger selectIndex;

@end

NS_ASSUME_NONNULL_END
