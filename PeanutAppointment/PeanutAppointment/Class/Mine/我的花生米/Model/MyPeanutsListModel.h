//
//  MyPeanutsListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyFansModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyPeanutsListModel : NSObject

///发布技能人数
@property (nonatomic, copy) NSString *skillsNumber;

///花生米数量
@property (nonatomic, copy) NSString *fansSum;

///粉丝列表
@property (nonatomic, strong) NSArray <MyFansModel *>*fansList;

@end

@interface MyFansModel : NSObject

///注册时间
@property (nonatomic, copy) NSString *regTime;

///1：已发布技能   0：没有发布技能
@property (nonatomic, copy) NSString *isCertification;

///1：已认证 ，其他都是未认证
@property (nonatomic, copy) NSString *idCard;

///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

/*
 "regTime": "2018-09-11T05:38:40.000+0000",
 "isCertification": "0",
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",
 "nikeName": "曹操1"

 */

@end


NS_ASSUME_NONNULL_END
