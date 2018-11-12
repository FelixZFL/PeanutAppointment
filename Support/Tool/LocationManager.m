//
//  LocationManager.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<BMKLocationManagerDelegate>

@end

@implementation LocationManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static LocationManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[LocationManager alloc] init];
        [instance setupLocationManager];
    });
    return instance;
}

- (void)setupLocationManager {
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    //_locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 5;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 5;
}

#pragma mark - public -

#pragma mark - getter -

@end
