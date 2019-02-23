//
//  PhotoAlbumModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PhotoAlbumPhotosModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAlbumModel : NSObject

///相片
@property (nonatomic, strong) NSArray<PhotoAlbumPhotosModel *> *photos;

///年
@property (nonatomic, copy) NSString *years;


/*
 [{
 "photos": [{
 "photoId","1",
 "typeName": "生活",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }],
 "years": "2014"
 }, {
 "photos": [{
 "photoId","1",
 "typeName": "生活",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }],
 "years": "2015"
 }, {
 "photos": [{
 "photoId","1",
 "typeName": "逛街",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }],
 "years": "2016"
 }, {
 "photos": [{
 "photoId","1",
 "typeName": "美食",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }],
 "years": "2017"
 }, {
 "photos": [{
 "photoId","1",
 "typeName": "生活",
 "photoTime": "09-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }, {
 "photoId","1",
 "typeName": "生活",
 "photoTime": "10-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }, {
 "photoId","1",
 "typeName": "逛街",
 "photoTime": "08-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }, {
 "photoId","1",
 "typeName": "逛街",
 "photoTime": "07-11",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }, {
 "photoId","1",
 "typeName": "美食",
 "photoTime": "09-14",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }, {
 "photoId","1",
 "typeName": "美食",
 "photoTime": "09-15",
 "photosUrl": "1.jpg,2.jpg,3.jpg,4.jpg"
 }],
 "years": "2018"
 }]
 
 */

@end

NS_ASSUME_NONNULL_END
