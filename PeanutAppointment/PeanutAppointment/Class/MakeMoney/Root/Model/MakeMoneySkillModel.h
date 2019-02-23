//
//  MakeMoneySkillModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/31.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MakeMoneySkillModel : NSObject


///数据id
@property (nonatomic, copy) NSString *ID;

///技能id
@property (nonatomic, copy) NSString *jnId;

///技能名称
@property (nonatomic, copy) NSString *jnName;


/*
 "jnId": "1", //技能id
 "jnName": "测试"//技能名称  jnId
 */

@end

NS_ASSUME_NONNULL_END
