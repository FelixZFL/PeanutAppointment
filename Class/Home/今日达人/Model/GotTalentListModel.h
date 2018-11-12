//
//  GotTalentListModel.h
//  PeanutAppointment
//
//  Created by felix on 2018/11/6.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GotTalentListModel : NSObject

///视频/直播地址
@property (nonatomic, copy) NSString *voidUrl;

///数据id
@property (nonatomic, copy) NSString *pvId;

///播放次数
@property (nonatomic, copy) NSString *playNumber;

///评论次数
@property (nonatomic, copy) NSString *comments;


/*
 "voidUrl": "xxxxxxx", //视频/直播地址
 "pvId","111", //数据id
 "playNumber",1, //播放次数少
 "comments",2 //评论次数
 */

@end

NS_ASSUME_NONNULL_END
