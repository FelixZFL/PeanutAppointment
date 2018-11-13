//
//  RechargeAlertListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RechargeAlertListModel : NSObject

///价格
@property (nonatomic, copy) NSString *rmb;
///id
@property (nonatomic, copy) NSString *ID;
///金砖数量
@property (nonatomic, copy) NSString *jzNumber;


/*
 "rmb": 20.00,    //价格
 "id": "5",            //id
 "jzNumber": 100 //金砖数量
 */

@end

NS_ASSUME_NONNULL_END
