//
//  RechargeViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RechargeViewController : BaseTableViewController

@property (nonatomic, copy) void (^submitSuccessBlock) (void);

@end

NS_ASSUME_NONNULL_END
