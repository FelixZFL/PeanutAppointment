//
//  ChangePasswordViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordViewController : BaseTableViewController

@property (nonatomic, copy) void (^submitSuccessBlock) (void);

@end

NS_ASSUME_NONNULL_END
