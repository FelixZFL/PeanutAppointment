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

///封面图
@property (nonatomic, copy) NSString *coverUrl;

///1：视频 /2：直播
@property (nonatomic, copy) NSString *videoType;

/*
 "voidUrl": "xxxxxxx", //视频/直播地址
 "pvId","111", //数据id
 "playNumber",1, //播放次数少
 "comments",2 //评论次数
 coverUrl = "https://outin-3a0966eea47a11e8b8f200163e1c7426.oss-cn-shanghai.aliyuncs.com/image/cover/E03F8CAB5FB64E659E78AACB3F199591-6-2.png?Expires=1542116306&OSSAccessKeyId=LTAInFumgYEtNMvC&Signature=ducRyl8khzsfPf3wXjgpF6AUapQ%3D";
 videoType = 1; 
 */

@end

NS_ASSUME_NONNULL_END
