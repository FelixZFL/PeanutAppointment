//
//  BillListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/27.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillListModel : NSObject

///时间
@property (nonatomic, copy) NSString *createTime;

///价格或者金砖数量
@property (nonatomic, copy) NSString *price;

///1：收入   2：支出
@property (nonatomic, copy) NSString *ptype;

///文字
@property (nonatomic, copy) NSString *content;


/*
 "createTime": "2018-09-11T08:28:47.000+0000",     //时间
 "price": 15.00,                                 //价格或者金砖数量
 "ptype": "2",                                  //1：收入   2：支出
 "content": "购买会员"                          //文字
 */

@end

NS_ASSUME_NONNULL_END
