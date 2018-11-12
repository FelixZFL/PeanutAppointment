//
//  MyMainPageModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainPageVisitorModel;
@class MyMainPageInfoModel;


NS_ASSUME_NONNULL_BEGIN

@interface MyMainPageModel : NSObject

@property (nonatomic, strong) NSArray <MainPageVisitorModel *>*list;

@property (nonatomic, strong) MyMainPageInfoModel *info;

@end

@interface MainPageVisitorModel : NSObject

///用户id
@property (nonatomic, copy) NSString *puId;

///头像
@property (nonatomic, copy) NSString *headUrl;

/*
 "puId": "2", //用户id
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg" //头像
 */

@end


@interface MyMainPageInfoModel : NSObject


///访客总数
@property (nonatomic, copy) NSString *fwNumber;

///手机号
@property (nonatomic, copy) NSString *phone;

///性别 （1:男/0:女）
@property (nonatomic, copy) NSString *sex;

///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

///地址
@property (nonatomic, copy) NSString *addr;

///年龄
@property (nonatomic, copy) NSString *age;

///点赞总数
@property (nonatomic, copy) NSString *likeSumNumber;

///身份认证 （身份证认证(0：未认证/1：已认证/2：待审核/3：审核失败)）用于判断用户是否身份认证
@property (nonatomic, copy) NSString *isCertification;

///支付宝账号（用户判断用户是否支付宝认证）
@property (nonatomic, copy) NSString *aliPayNumber;

///微信号（用户判断用户是否微信认证）
@property (nonatomic, copy) NSString *wxNumber;

/*
 "info": {
 "fwNumber": 10, //访客总数
 "phone": "13677697947", //手机号
 "sex": "1", //性别 （1:男/0:女）
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "nikeName": "梁大爷", //昵称
 "addr": "重庆市沙坪坝",//地址
 "age": 22, //年龄
 "likeSumNumber": 22, 点赞总数
 "isCertification": "1",//身份认证 （身份证认证(0：未认证/1：已认证/2：待审核/3：审核失败)）用于判断用户是否身份认证
 "aliPayNumber": "13677697947", //支付宝账号（用户判断用户是否支付宝认证）
 "wxNumber": "13677697947" //微信号（用户判断用户是否微信认证）
 }
 */

@end

NS_ASSUME_NONNULL_END
