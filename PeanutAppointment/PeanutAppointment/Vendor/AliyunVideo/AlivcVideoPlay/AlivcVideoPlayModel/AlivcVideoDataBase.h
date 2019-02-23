//
//  AlivcVideoDataBase.h
//  AliyunVideoClient_Entrance
//
//  Created by Zejian Cai on 2018/6/13.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVCDownloadVideo.h"

@interface AlivcVideoDataBase : NSObject

/**
 单例

 @return 单例
 */
+ (instancetype)shared;

/**
 存储下载的视频

 @param video 下载的视频
 */
- (void)addVideo:(AVCDownloadVideo *)video;

/**
 删除下载的视频

 @param video 下载的视频
 */
- (BOOL)deleteVideo:(AVCDownloadVideo *)video;

/**
 更新下载的视频

 @param video 下载的视频
 */
- (BOOL)updateVideo:(AVCDownloadVideo *)video;

/**
 获取所有的数据

 @return 所有的本地的视频，已下载的和未下载的
 */
- (NSArray <AVCDownloadVideo *>*)getAllVideo;
@end
