//
//  SkillListModel.h
//  PeanutAppointment
//
//  Created by felix on 2018/11/15.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkillListModel : NSObject

///技能名称
@property (nonatomic, copy) NSString *jnName;

///技能id
@property (nonatomic, copy) NSString *jnId;

/*
 "jnName":"测试", //技能名称
 "jnId":"121212121212" //技能id
 */

@end

NS_ASSUME_NONNULL_END
