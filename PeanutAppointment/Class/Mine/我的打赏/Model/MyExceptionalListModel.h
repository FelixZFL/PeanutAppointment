//
//  MyExceptionalListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyExceptionalListModel : NSObject

///返利
@property (nonatomic, copy) NSString *price;

///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

///金钻
@property (nonatomic, copy) NSString *goldNumber;

/*
 "price": 100.00,
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",
 "nikeName": "曹操2",
 "goldNumber": 79
 */

@end

NS_ASSUME_NONNULL_END
