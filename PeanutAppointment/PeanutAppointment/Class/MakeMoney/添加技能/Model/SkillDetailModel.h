//
//  SkillDetailModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/17.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SkillDetailModel : NSObject


///服务方式：（1：ta找我 2：我找ta   3:ta找我我找ta）
@property (nonatomic, copy) NSString *serviceType;
///服务价格
@property (nonatomic, copy) NSString *servicePrice;
///服务介绍
@property (nonatomic, copy) NSString *introduce;
///定金
@property (nonatomic, copy) NSString *downPayment;
///技能介绍
@property (nonatomic, copy) NSString *selfIntroduction;
///工作经历
@property (nonatomic, copy) NSString *experience;
///服务时间 （1:周一2:周二3:周三.........）
@property (nonatomic, copy) NSString *serviceTime;
///
//@property (nonatomic, copy) NSString *serviceType;
///
//@property (nonatomic, copy) NSString *serviceType;


/*
 "serviceType": "1",                              //服务方式：（1：ta找我 2：我找ta   3:ta找我我找ta）
 "servicePrice": 20,                              //服务价格
 "introduce": "服务好",                        //服务结束
 "downPayment": 20,                          //定金
 "selfIntroduction": "专业的技能服务",//技能介绍
  "experience": "给大型公司服务过",   //工作经历
 "serviceTime": "1,2,3,4,5,6,7"           //服务时间 （1:周一2:周二3:周三.........）
 */

@end

NS_ASSUME_NONNULL_END
