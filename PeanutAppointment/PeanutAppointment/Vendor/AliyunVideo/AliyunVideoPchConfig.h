//
//  AliyunVideoPchConfig.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/9.
//  Copyright © 2018 felix. All rights reserved.
//

#ifndef AliyunVideoPchConfig_h
#define AliyunVideoPchConfig_h

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SizeWidth(W) (W *CGRectGetWidth([[UIScreen mainScreen] bounds])/320)
#define SizeHeight(H) (H *(ScreenHeight)/568)
#define RGBToColor(R,G,B)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:1.0]
#define rgba(R,G,B,A)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:A]
#define BundleID [[NSBundle mainBundle] bundleIdentifier]
//#define BundleID @"com.aliyun.aliyunvideosdkpro"
// 注释为Release版
//#define kQPEnableDevNetwork

#ifdef kQPEnableDevNetwork
#define kQPResourceHostUrl @"http://m.api.inner.alibaba.net"
#else
#define kQPResourceHostUrl @"https://m-api.qupaicloud.com"
#endif

#define IS_IPHONEX (([[UIScreen mainScreen] bounds].size.height-812)?NO:YES)
#define SafeTop (([[UIScreen mainScreen] bounds].size.height-812) ? 20 : 44)
#define SafeBottom (([[UIScreen mainScreen] bounds].size.height-812) ? 0 : 43)
#define StatusBarHeight (([[UIScreen mainScreen] bounds].size.height-812) ? 20 : 44)

#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"\n[File:%s]\n" "[Function:%s]\n" "[Line:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...);
#endif

// pushflow
#define AlivcScreenWidth  [UIScreen mainScreen].bounds.size.width
#define AlivcScreenHeight  [UIScreen mainScreen].bounds.size.height
#define AlivcSizeWidth(W) (W*(AlivcScreenWidth)/320)
#define AlivcSizeHeight(H) (H*(AlivcScreenHeight)/568)

#define IPHONEX (AlivcScreenWidth == 375.f && AlivcScreenHeight == 812.f)

#define AlivcRGB(R,G,B)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:1.0]
#define AlivcRGBA(R,G,B,A)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:A]





#define AlivcUserDefaultsIndentifierFirst @"AlivcUserDefaultsIndentifierFirst"

//二维码界面模块
#define LBXScan_Define_UI
#define LBXScan_Define_Native



#endif /* AliyunVideoPchConfig_h */