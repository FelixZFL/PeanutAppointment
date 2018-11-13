//
//  AddSkillDetailViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum : NSUInteger {
    AddSkillDetailViewType_add,
    AddSkillDetailViewType_edit,
} AddSkillDetailViewType;

NS_ASSUME_NONNULL_BEGIN

@interface AddSkillDetailViewController : BaseTableViewController

@property (nonatomic, assign) AddSkillDetailViewType type;

///技能名
@property (nonatomic, strong) NSString *pasName;


//@property (nonatomic, strong) <#Class#> *<#name#>;

@end

NS_ASSUME_NONNULL_END
