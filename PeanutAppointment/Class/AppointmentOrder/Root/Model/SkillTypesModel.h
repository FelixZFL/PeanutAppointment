//
//  SkillTypesModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SkillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SkillTypesModel : NSObject

///名字
@property (copy , nonatomic) NSString *pasName;
///id
@property (copy , nonatomic) NSString *pasId;

///数组
@property (strong , nonatomic) NSMutableArray<SkillModel *> *list;

@end

NS_ASSUME_NONNULL_END
