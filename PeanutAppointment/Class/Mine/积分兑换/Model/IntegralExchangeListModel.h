//
//  IntegralExchangeListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntegralExchangeListModel : NSObject


///
@property (nonatomic, copy) NSString *piId;

///消耗积分
@property (nonatomic, copy) NSString *xhjf;

///天数
@property (nonatomic, copy) NSString *vipNumber;


/*
 "piId": "1",
 "xhjf": 300, //消耗积分
 "vipNumber": 3//天数
 */

@end

NS_ASSUME_NONNULL_END
