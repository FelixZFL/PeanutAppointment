//
//  NetworkResponseModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VersionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkResponseModel : NSObject

@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) VersionModel *version;

@end

NS_ASSUME_NONNULL_END
