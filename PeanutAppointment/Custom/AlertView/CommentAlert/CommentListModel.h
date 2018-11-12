//
//  CommentListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/5.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentListModel : NSObject

///评论时间
@property (nonatomic, copy) NSString *createTime;

///头像
@property (nonatomic, copy) NSString *headUrl;

///昵称
@property (nonatomic, copy) NSString *nikeName;

///评论内容
@property (nonatomic, copy) NSString *content;


/*
 "createTime": "2018-11-09", //评论时间
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "nikeName": "梁大爷",//昵称
 "content": "好看"//评论内容
 */

@end

NS_ASSUME_NONNULL_END
