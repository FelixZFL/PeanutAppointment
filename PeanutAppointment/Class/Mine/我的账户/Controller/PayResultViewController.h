//
//  PayResultViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayResultViewController : BaseTableViewController

///支付是否成功
@property (nonatomic, assign) BOOL isSuccess;

///支付金额
@property (nonatomic, copy) NSString *money;

@end

NS_ASSUME_NONNULL_END
