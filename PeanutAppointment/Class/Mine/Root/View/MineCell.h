//
//  MineCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MineModel;

NS_ASSUME_NONNULL_BEGIN

@interface MineCell : BaseTableViewCell

@property (nonatomic, strong) MineModel *model;

@end

NS_ASSUME_NONNULL_END

