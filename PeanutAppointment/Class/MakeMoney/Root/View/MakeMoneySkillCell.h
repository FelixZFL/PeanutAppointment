//
//  MakeMoneySkillCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MakeMoneySkillModel;

NS_ASSUME_NONNULL_BEGIN

@interface MakeMoneySkillCell : BaseTableViewCell

@property (nonatomic, copy) void(^editBlock) (MakeMoneySkillModel *model);
@property (nonatomic, copy) void(^deleteBlock) (MakeMoneySkillModel *model);

@property (nonatomic, strong) MakeMoneySkillModel *model;

@end

NS_ASSUME_NONNULL_END
