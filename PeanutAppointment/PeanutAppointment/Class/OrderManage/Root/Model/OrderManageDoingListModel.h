//
//  OrderManageDoingListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/16.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderManageDoingListModel : NSObject

///距离 KM
@property (nonatomic, copy) NSString *distance;
///
@property (nonatomic, copy) NSString *age;
///
@property (nonatomic, copy) NSString *sex;
///
@property (nonatomic, copy) NSString *pasName;
///
@property (nonatomic, copy) NSString *orderId;
///
@property (nonatomic, copy) NSString *phone;
///
@property (nonatomic, copy) NSString *createTime;
///
@property (nonatomic, copy) NSString *headUrl;
///
@property (nonatomic, copy) NSString *nikeName;
///1：不显示应邀     2:显示应邀
@property (nonatomic, copy) NSString *state;
///
@property (nonatomic, copy) NSString *aliPayNumber;
///
@property (nonatomic, copy) NSString *wxNumber;



/*
 "distance",10,//  KM
 age
 sex
 "pasName": "都市丽人",  //技能名称
 "orderId": "d235b9b3929a443e99d06c2a65a1b8df",//订单id
 "phone": "13677697947",//手机号用于判断是否验证手机
 "createTime": "2018-11-11",//发布时间
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/hsyj/1542080518782.jpg", //头像
 "nikeName": "哈哈", //昵称
 "state": 2,    //1：不显示应邀     2:显示应邀
 "aliPayNumber": "34567", //支付宝账号用于验证是否验证支付宝
 "wxNumber": "o6VVdw6CbZEauOPxkNZRaAuaM6-k"//微信用于验证是否验证微信
 */

@end

NS_ASSUME_NONNULL_END
