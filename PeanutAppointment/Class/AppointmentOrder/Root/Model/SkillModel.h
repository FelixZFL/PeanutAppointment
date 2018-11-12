//
//  SkillModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkillModel : NSObject

///技能名称
@property (copy , nonatomic) NSString *pasName;
///id
@property (copy , nonatomic) NSString *pasId;


///是否点击
@property (nonatomic,assign) BOOL isSelect;


@end

NS_ASSUME_NONNULL_END
