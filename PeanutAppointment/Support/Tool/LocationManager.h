//
//  LocationManager.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMKLocationKit/BMKLocationManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

+(instancetype)sharedManager;

@property (nonatomic, strong) BMKLocationManager *locationManager;

@end

NS_ASSUME_NONNULL_END
