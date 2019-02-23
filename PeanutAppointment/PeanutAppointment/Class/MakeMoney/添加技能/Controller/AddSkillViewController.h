//
//  AddSkillViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

@class SkillModel;

NS_ASSUME_NONNULL_BEGIN

@interface AddSkillViewController : BaseTableViewController

///编辑 需要实现
@property (nonatomic, copy) void(^chooseSkillBlock)(SkillModel *skillModel);

@end

NS_ASSUME_NONNULL_END
