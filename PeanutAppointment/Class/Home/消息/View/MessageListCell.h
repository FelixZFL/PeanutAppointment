//
//  MessageListCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageListCell : BaseTableViewCell

@property (nonatomic, strong) MessageModel *model;

@end

NS_ASSUME_NONNULL_END
