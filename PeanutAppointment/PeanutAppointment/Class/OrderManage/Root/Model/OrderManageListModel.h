//
//  OrderManageListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/7.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderManageInvitedListModel;

NS_ASSUME_NONNULL_BEGIN

@interface OrderManageListModel : NSObject

///类别
@property (nonatomic, copy) NSString *pasName;
///发布时间
@property (nonatomic, copy) NSString *createTime;
///有效期     根据发布时间来计算
@property (nonatomic, copy) NSString *dayNumber;
///前端用不到
@property (nonatomic, copy) NSString *state;
///应邀者列表
@property (nonatomic, strong) NSArray<OrderManageInvitedListModel *> *invitedList;
///订单id
@property (nonatomic, copy) NSString *poId;



/*
 "pasName": "喝咖啡",        //类别
 "createTime": "2018-09-11",//发布时间
 "dayNumber": 1, //有效期     根据发布时间来计算
 "state": "1",   //前端用不到
 "invitedList": [{  //应邀者列表
 }],
 "poId": "ae7cb6629de04a8faad01d25b1fd1927"  //订单id
 */

@end

NS_ASSUME_NONNULL_END



@interface OrderManageInvitedListModel : NSObject

///用户id
@property (nonatomic, copy) NSString *puId;
///头像
@property (nonatomic, copy) NSString *headUrl;
///是否查看  1:已查看  0:未查看
@property (nonatomic, copy) NSString *isQuery;


/*
 "puId": "1",  //用户id
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg",  //头像
 "isQuery": "0"  //是否查看  1:已查看  0:未查看
 */

@end
