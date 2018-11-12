//
//  PhotoAlbumPhotosModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbumPhotosModel : NSObject


///id
@property (nonatomic, copy) NSString *photoId;
///生活
@property (nonatomic, copy) NSString *typeName;
///时间
@property (nonatomic, copy) NSString *photoTime;
///图片地址 逗号分隔
@property (nonatomic, copy) NSString *photosUrl;


/*
 "photoId","1",
 "typeName": "生活",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 */

@end

NS_ASSUME_NONNULL_END
