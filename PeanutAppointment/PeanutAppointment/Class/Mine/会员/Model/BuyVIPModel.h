//
//  BuyVIPModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyVIPModel : NSObject

///数据ID
@property (nonatomic, copy) NSString *pvbId;
///价格
@property (nonatomic, copy) NSString *price;
///天数
@property (nonatomic, copy) NSString *dayNumber;

///是否选中
@property (nonatomic, assign) BOOL selected;

/*
 "pvbId": "1",            //
 "price": 3.00,           //价格
 "dayNumber": "五天"    //
 */

@end

NS_ASSUME_NONNULL_END
