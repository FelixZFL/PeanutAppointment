//
//  UserInfoModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

///头像
@property (nonatomic, copy) NSString *headUrl;
///昵称
@property (nonatomic, copy) NSString *nikeName;
///年龄
@property (nonatomic, copy) NSString *age;
///性别
@property (nonatomic, copy) NSString *sex;
///积分
@property (nonatomic, copy) NSString *integral;

/*
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",
 "nikeName": "梁大爷"
 */

@end

NS_ASSUME_NONNULL_END
