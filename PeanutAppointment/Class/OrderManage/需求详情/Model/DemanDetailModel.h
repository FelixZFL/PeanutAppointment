//
//  DemanDetailModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/16.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemanDetailModel : NSObject


///技能名称
@property (nonatomic, copy) NSString *pasName;
///发布时间
@property (nonatomic, copy) NSString *createTime;
///有效时间
@property (nonatomic, copy) NSString *dayNumber;
///服务方式
@property (nonatomic, copy) NSString *serviceType;
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
///服务价格
@property (nonatomic, copy) NSString *servicePrice;
///优势
@property (nonatomic, copy) NSString *experience;
///应邀时间
@property (nonatomic, copy) NSString *yyTIme;


/*
 pasName,//技能名称
 createTime,//发布时间
 dayNumber,//有效时间
 serviceType,//服务方式
 headUrl,//头像url
 nikeName,//昵称
 age,//年龄
 sex,//性别
 phone,//手机号
 wxNumber,//微信
 aliPayNumber,//支付宝
 servicePrice,//服务价格
 experience//优势
 yyTIme://应邀时间
 */

@end

NS_ASSUME_NONNULL_END
