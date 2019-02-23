//
//  OrderManageDoneListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/16.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderManageDoneListModel : NSObject


/*
 "orderId",//订单ID
 "headUrl": //头像url
 "nikeName": //昵称
 "age": //年龄
 "sex": //性别
 "phone": //手机号
 "wxNumber": //微信号
 "aliPayNumber": //支付宝
 "createTime": //发布时间
 "pasName": //技能名称
 “state”：  //1:已过期   2:已评价    3:未评价
 "pasId","1212"//技能id（用于评价的时候用，）
 */



///
@property (nonatomic, copy) NSString *orderId;
///
@property (nonatomic, copy) NSString *headUrl;
///
@property (nonatomic, copy) NSString *nikeName;
///
@property (nonatomic, copy) NSString *age;
///
@property (nonatomic, copy) NSString *sex;
///
@property (nonatomic, copy) NSString *phone;
///
@property (nonatomic, copy) NSString *wxNumber;
///
@property (nonatomic, copy) NSString *aliPayNumber;
///
@property (nonatomic, copy) NSString *createTime;
///
@property (nonatomic, copy) NSString *pasName;

///1:已过期   2:已评价    3:未评价  ///  ( 接单中   1：不显示应邀     2:显示应邀)
@property (nonatomic, copy) NSString *state;

///技能id（用于评价的时候用，）
@property (nonatomic, copy) NSString *pasId;



/*----------------------------接单中-------------------------------------*/
///距离 KM
@property (nonatomic, copy) NSString *distance;

/*
 "distance",10,//  KM
 "state": 2,    //1：不显示应邀     2:显示应邀
 */


@end

NS_ASSUME_NONNULL_END
