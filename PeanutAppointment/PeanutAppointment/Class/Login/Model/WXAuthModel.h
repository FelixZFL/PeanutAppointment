//
//  WXAuthModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXAuthModel : NSObject

///接口调用凭证
@property (nonatomic, copy) NSString *access_token;

///access_token接口调用凭证超时时间，单位（秒）
@property (nonatomic, assign) NSInteger expires_in;

///授权用户唯一标识
@property (nonatomic, copy) NSString *openid;

///用户刷新access_token
@property (nonatomic, copy) NSString *refresh_token;

///用户授权的作用域，使用逗号（,）分隔
@property (nonatomic, copy) NSString *scope;

///当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段
@property (nonatomic, copy) NSString *unionid;

/*
 "access_token" = "14_c6ulRmd5ZOuoP8ZHcPZCPhjzgNH2JybOVmAJpKQ2NqDqTTPQ2I7R35R5Qt-L8SW_JaTZqtBJywmN_9FeYcGfXct2F10UJ9IJjOPYnKTILnw";
 "expires_in" = 7200;
 openid = "o-Jx4wqMFIbYTIJrF2fRVtfD41Z8";
 "refresh_token" = "14_TGyAvegz2UFYepVjifeMMEwgaGUtuynpTaQpBpCzmQOOSawOU-Dskdbc-WHBKdg_0UpAm5p7JwqGShKFz2KOnq7Gb_lNulM3nNE_qKXJX2w";
 scope = "snsapi_userinfo";
 unionid = "o6VVdw6LfUuMIOc9-wLGXHYH_29c";
 */

@end

NS_ASSUME_NONNULL_END
