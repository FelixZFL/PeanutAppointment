//
//  DemandDetailViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemandDetailViewController : BaseTableViewController

///订单id
@property (nonatomic, copy) NSString *orderId;

///应邀者id
@property (nonatomic, copy) NSString *yUserId;

///状态
@property (nonatomic, copy) NSString *state;

///技能id
//@property (nonatomic, copy) NSString *jnId;

@end

NS_ASSUME_NONNULL_END
