//
//  HomeModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/4.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeIndexUserModel.h"
@class HomeBannerModel,HomeGamesModel,HomeHotUserModel,HomeVideoHotUserModel,HomeToolModel,HomeTypeListModel,HomeNoticeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject

///APP首页 Banner图片
@property (nonatomic, strong) NSArray<HomeBannerModel *> *banner;
///APP首页 游戏三张图片
@property (nonatomic, strong) NSArray<HomeGamesModel *> *gamePhotos;
///今日之星
@property (nonatomic, strong) NSArray<HomeHotUserModel *> *toDayHotUser;
///今日达人列表
@property (nonatomic, strong) NSArray<HomeVideoHotUserModel *> *toDayVideoHotUser;
///首页推荐用户
@property (nonatomic, strong) NSArray<HomeIndexUserModel *> *indexUser;
///
@property (nonatomic, strong) HomeToolModel *tools;
///首页分类类型
@property (nonatomic, strong) NSArray<HomeTypeListModel *> *typeList;
///上线通知
@property (nonatomic, strong) NSArray<HomeNoticeListModel *> *notice;
///是否显示红包
@property (nonatomic, copy) NSString *isShowRedPage;
///
@property (nonatomic, copy) NSString *sign;

/*
 sign = 1;
 isShowRedPage = 1;
 notice = "xxx\U4e0a\U7ebf\U4e86";
 */

@end

NS_ASSUME_NONNULL_END


@interface HomeBannerModel : NSObject

///#代表不跳转任何地址，相反跳转
@property (nonatomic, copy) NSString *clickUrl;

///图片
@property (nonatomic, copy) NSString *photoUrl;

/*
 clickUrl = "#";
 photoUrl = "https://goss.veer.com/creative/vcg/veer/800water/veer-300750893.jpg";
 */

@end


@interface HomeGamesModel : NSObject

///#代表不跳转任何地址，相反跳转
@property (nonatomic, copy) NSString *clickUrl;

///图片
@property (nonatomic, copy) NSString *photoUrl;

///1：跳转网页地址 2:跳转APP，（注：由于第一张图片本来就是跳转到APP内部页面 所以 这里我标记了一个2 并且 地址#）
@property (nonatomic, copy) NSString *pType;

/*
 clickUrl = "#";
 pType = 2;
 photoUrl = "https://goss.veer.com/creative/vcg/veer/800water/veer-321894067.jpg";
 */

@end

@interface HomeHotUserModel : NSObject

///头像
@property (nonatomic, copy) NSString *headUrl;

///用户id
@property (nonatomic, copy) NSString *userId;

/*
 headUrl = "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg";
 userId = 1;
 */

@end

@interface HomeVideoHotUserModel : NSObject

///1：视频 /2：直播
@property (nonatomic, copy) NSString *videoType;

///视频地址或者直播地址
@property (nonatomic, copy) NSString *voidUrl;

/*
 videoType = 1;
 voidUrl = xx;
 */

@end


@interface HomeToolModel : NSObject

///图片地址
@property (nonatomic, copy) NSString *photoUrl;

/*
 photoUrl = "\U6d4b\U8bd5\U6587\U5b57\Uff0c\U5f39\U7a97";
 */

@end

@interface HomeTypeListModel : NSObject

///分类名称
@property (nonatomic, copy) NSString *pasName;
///分类id
@property (nonatomic, copy) NSString *pasId;

/*
 pasId = 20;
 pasName = "\U901b\U8857";
 */

@end


@interface HomeNoticeListModel : NSObject

///昵称
@property (nonatomic, copy) NSString *nikeName;

/*
 nikeName = "\U6210\U719f\U9700\U8981\U7684\U662f\U7d93\U66c6\U3001\U4e0a\U7ebf\U4e86";
 */

@end
