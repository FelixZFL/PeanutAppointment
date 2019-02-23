//
//  AddSkillDetailViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

@class SkillDetailModel;

typedef enum : NSUInteger {
    AddSkillDetailViewType_add,
    AddSkillDetailViewType_edit,
} AddSkillDetailViewType;

NS_ASSUME_NONNULL_BEGIN

@interface AddSkillDetailViewController : BaseTableViewController

@property (nonatomic, assign) AddSkillDetailViewType type;
//编辑需要传
@property (nonatomic, strong) SkillDetailModel *skillDetail;

///技能名
@property (nonatomic, copy) NSString *pasName;
//技能id
@property (nonatomic, copy) NSString *pasId;



@end

NS_ASSUME_NONNULL_END
