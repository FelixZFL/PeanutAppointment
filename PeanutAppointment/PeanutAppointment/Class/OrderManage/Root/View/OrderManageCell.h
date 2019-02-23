//
//  OrderManageCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class OrderManageDoneListModel;

NS_ASSUME_NONNULL_BEGIN

@interface OrderManageCell : BaseTableViewCell

@property (nonatomic, copy) void(^buttonClickBlock) (UIButton *sender, OrderManageDoneListModel *model);

- (void)setModel:(OrderManageDoneListModel * _Nonnull)model isDone:(BOOL)isDone;

@end

NS_ASSUME_NONNULL_END
