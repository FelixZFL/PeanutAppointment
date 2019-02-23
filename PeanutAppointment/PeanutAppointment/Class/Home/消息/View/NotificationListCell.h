//
//  NotificationListCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class SystemMessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface NotificationListCell : BaseTableViewCell

@property (nonatomic, strong) SystemMessageModel *model;

@end

NS_ASSUME_NONNULL_END
