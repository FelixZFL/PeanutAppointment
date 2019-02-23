//
//  MajiangRoomCardModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/13.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MajiangRoomCardModel : NSObject

///数据id
@property (nonatomic, copy) NSString *prbId;
///价格
@property (nonatomic, copy) NSString *price;
///房卡数量
@property (nonatomic, copy) NSString *roomCardNumber;

/*
 "prbId": "1", //数据id
 "price": 10.00, //价格
 "roomCardNumber": 10 //房卡数量
 */

@end

NS_ASSUME_NONNULL_END
