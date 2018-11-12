//
//  BillListCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class BillListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BillListCell : BaseTableViewCell

@property (nonatomic, strong) BillListModel *model;

@end

NS_ASSUME_NONNULL_END
