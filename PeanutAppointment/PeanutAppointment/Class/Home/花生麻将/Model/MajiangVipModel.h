//
//  MajiangVipModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/13.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MajiangVipModel : NSObject

///数据id
@property (nonatomic, copy) NSString *pgvId;
///价格
@property (nonatomic, copy) NSString *price;
///赠送房卡数量
@property (nonatomic, copy) NSString *roomCardNumber;
///vip天数
@property (nonatomic, copy) NSString *dayNumber;

/*
 "pgvId": "1", //数据id
 "price": 100.00, //价格
 "roomCardNumber": 100, //赠送房卡数量
 "dayNumber": 60 //vip天数
 */

@end

NS_ASSUME_NONNULL_END
