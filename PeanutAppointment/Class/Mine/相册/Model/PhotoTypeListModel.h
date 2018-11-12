//
//  PhotoTypeListModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTypeListModel : NSObject

///名称
@property (nonatomic, copy) NSString *typeName;

///类型id
@property (nonatomic, copy) NSString *ptId;


/*
 "typeName": "生活", //名称
 "ptId": "1" //类型id
 */

@end

NS_ASSUME_NONNULL_END
