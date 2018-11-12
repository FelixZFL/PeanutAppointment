//
//  RewardModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/7.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RewardGiftListModel,RewardRankingModel;

NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject

///金砖余额
@property (nonatomic, copy) NSString *masonry;

///礼物列表
@property (nonatomic, strong) NSArray<RewardGiftListModel *> *giftList;

///排行榜数据
@property (nonatomic, strong) NSArray<RewardRankingModel *> *ranking;

/*
 "masonry": 200, //金砖余额
 "giftList": [{
 }],
 "ranking": [
 ]
 
 */

@end

NS_ASSUME_NONNULL_END


@interface RewardGiftListModel : NSObject


///礼物名字
@property (nonatomic, copy) NSString *pName;

///id
@property (nonatomic, copy) NSString *pgId;

///所需的金砖数量
@property (nonatomic, copy) NSString *jzNumber;


/*
 "pName": "鲜花", //礼物名字
 "pgId": "1", //id
 "jzNumber": 50 //所需的金砖数量
 */

@end




@interface RewardRankingModel : NSObject


///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

///送出的金砖数量
@property (nonatomic, copy) NSString *jzNumber;


/*
 "headUrl": "1.jpg", //头像
 "nikeName": "3", //昵称
 "jzNumber": 200 //送出的金砖数量
 */

@end
