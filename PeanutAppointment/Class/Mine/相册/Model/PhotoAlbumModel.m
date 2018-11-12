//
//  PhotoAlbumModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PhotoAlbumModel.h"

@implementation PhotoAlbumModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"photos":[PhotoAlbumPhotosModel class]};
}

@end
