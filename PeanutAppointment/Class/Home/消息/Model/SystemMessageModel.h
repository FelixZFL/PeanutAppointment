//
//  SystemMessageModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/6.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemMessageModel : NSObject

///时间
@property (nonatomic, copy) NSString *createTime;

///标题
@property (nonatomic, copy) NSString *titles;

///内容
@property (nonatomic, copy) NSString *content;

/*
 "createTime": "2018-11-12T04:12:12.000+0000",
 "titles": "通知3",
 "content": "<h1>通知</h1>"
 */

@end

NS_ASSUME_NONNULL_END
