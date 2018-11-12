//
//  MyAccountInfoModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/27.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAccountInfoModel : NSObject

///红包余额
@property (nonatomic, copy) NSString *redPacket;
///返利统计
@property (nonatomic, copy) NSString *rebate;
///余额
@property (nonatomic, copy) NSString *balanceOutstanding;
///未到账
@property (nonatomic, copy) NSString *notAccount;
///头像
@property (nonatomic, copy) NSString *headUrl;
///昵称
@property (nonatomic, copy) NSString *nikeName;
///身份证审核状态(0：未认证/1：已认证/2：待审核/3：审核失败)
@property (nonatomic, copy) NSString *idCard;
///支付密码
@property (nonatomic, copy) NSString *withdrawPassword;
///年龄
@property (nonatomic, copy) NSString *age;
///性别
@property (nonatomic, copy) NSString *sex;
///地址
@property (nonatomic, copy) NSString *addr;

/*
 "redPacket": 0.00,    //红包余额
 "rebate": 200.00,     //返利统计
 "idCard": "0",       //
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",  //头像
 "balanceOutstanding": 0.00,   //余额
 "nikeName": "梁大爷"       //昵称
 "age",      //年龄
 "sex",         //性别
 "addr",             //地址
 "withdrawPassword",   //支付密码
 
 */

@end

NS_ASSUME_NONNULL_END
