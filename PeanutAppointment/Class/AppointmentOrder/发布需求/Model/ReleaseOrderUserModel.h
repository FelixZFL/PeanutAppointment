//
//  ReleaseOrderUserModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/31.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseOrderUserModel : NSObject

///距离 （公里）
@property (nonatomic, copy) NSString *distance;
///性别（1:男 /0:女）
@property (nonatomic, copy) NSString *sex;
///头像
@property (nonatomic, copy) NSString *headUrl;
///昵称
@property (nonatomic, copy) NSString *nikeName;
///年龄
@property (nonatomic, copy) NSString *age;


/*
 "distance": 0.0, //距离 （公里）
 "sex": "0", //性别（1:男 /0:女）
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "nikeName": "曹操1",//昵称
 "age": 22//年龄
 */

@end

NS_ASSUME_NONNULL_END
