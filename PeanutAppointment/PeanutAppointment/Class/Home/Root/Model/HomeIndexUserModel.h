//
//  HomeIndexUserModel.h
//  PeanutAppointment
//
//  Created by felix on 2018/11/5.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeIndexUserModel : NSObject

///用户id
@property (nonatomic, copy) NSString *userId;
///1:男 2:女
@property (nonatomic, copy) NSString *sex;
///头像
@property (nonatomic, copy) NSString *headUrl;
///相册图片 多张以逗号分隔
@property (nonatomic, copy) NSString *photos;
///昵称
@property (nonatomic, copy) NSString *nikeName;
///年龄
@property (nonatomic, copy) NSString *age;
///距离 单位KM 此字段非必返回
@property (nonatomic, copy) NSString *distance;
///技能id（注：此id还用于查看别人首页的时候会用到）
@property (nonatomic, copy) NSString *pusId;
//技能名称
@property (nonatomic, copy) NSString *jnName;
//数据id
@property (nonatomic, copy) NSString *ID;

///评论数量
@property (nonatomic, copy) NSString *commentNumber;
///点赞数量
@property (nonatomic, copy) NSString *likeNumber;
///金砖数量
@property (nonatomic, copy) NSString *goldNumber;



///手机号，如果手机号不为空说明已通过手机认证
@property (nonatomic, copy) NSString *phone;
///微信
@property (nonatomic, copy) NSString *wxNumber;
///支付宝账号
@property (nonatomic, copy) NSString *aliPayNumber;
///身份证号
@property (nonatomic, copy) NSString *cardNumber;


/*
 "commentNumber": 1, //评论数量
 "sex": "1", //1:男 2:女
 "pusId": "1", //技能id（注：此id还用于查看别人首页的时候会用到）
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "userId": "1", //用户id
 "photos": "1.png,2.png,3.png", //相册图片 多张以逗号分隔
 "goldNumber": 1, //金砖数量
 "phone": "13677697947", //手机号，如果手机号不为空说明已通过手机认证
 "nikeName": "梁大爷", //昵称
 "aliPayNumber": "13677697947",//支付宝账号
 "likeNumber": 1, //点赞数量
 "cardNumber": "500224199301057896",//身份证号
 "age": "25", //年龄
 "wxNumber": "13677697947" //微信
 "distance",10 //距离 单位KM 此字段非必返回
 
 */


@end

NS_ASSUME_NONNULL_END
