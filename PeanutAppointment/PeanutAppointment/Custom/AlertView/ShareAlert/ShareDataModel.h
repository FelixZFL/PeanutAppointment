//
//  ShareDataModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareDataModel : NSObject

/// 头像
@property (nonatomic, copy) NSString *headUrl;
/// 昵称
@property (nonatomic, copy) NSString *nikeName;
/// 用户主页
@property (nonatomic, copy) NSString *indexPage;



/*
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "nikeName": "梁大爷",//昵称
 "indexPage": "http://www.baidu.com"//用户主页
 */

@end

NS_ASSUME_NONNULL_END
