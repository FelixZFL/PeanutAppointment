//
//  VersionModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/11.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VersionUpdateAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VersionModel : NSObject

/*
 androidCode = 1002;
 androidSerialNumber = "1.0.0.2";
 described = "\U4fee\U590d\U4e86\U5de8\U5f62BUG";
 iosCode = 102;
 iosSerialNumber = "1.0.2";
 isUpdate = 1;
 url = "http://39.107.76.196:8084/xbsc.apk";
 */

///
@property (nonatomic, strong) NSString *androidCode;

///
@property (nonatomic, strong) NSString *androidSerialNumber;

///更新描述
@property (nonatomic, strong) NSString *described;

///
@property (nonatomic, strong) NSString *iosCode;

///
@property (nonatomic, strong) NSString *iosSerialNumber;

///1：强制更新 0：非强制更新"
@property (nonatomic, strong) NSString *isUpdate;

///
@property (nonatomic, strong) NSString *url;


@end

NS_ASSUME_NONNULL_END
