//
//  RebateRankingModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/5.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RebateRankingModel : NSObject

///注册时间
@property (nonatomic, copy) NSString *regTime;

///钱
@property (nonatomic, copy) NSString *price;

///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

/*
 "regTime": "2018-09-11T05:37:21.000+0000",  //注册时间
 "price": 200,                               //钱
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",   //头像
 "nikeName": "梁大爷"                       //昵称
 */


@end

NS_ASSUME_NONNULL_END
