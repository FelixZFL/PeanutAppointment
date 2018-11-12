//
//  MyExceptionalModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyExceptionalListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyExceptionalModel : NSObject


///金钻
@property (nonatomic, copy) NSString *gold;

///返利
@property (nonatomic, copy) NSString *price;

///
@property (nonatomic, strong) NSArray<MyExceptionalListModel *> *list;

/*
 "gold": 894,
 "price": 1100.00,
 list
 */

@end

NS_ASSUME_NONNULL_END
