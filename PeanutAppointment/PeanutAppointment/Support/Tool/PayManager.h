//
//  PayManager.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXReqModel;

@interface PayManager : NSObject

+(instancetype)sharedManager;

//支付宝回调
- (void)processOrderWithPaymentResultWithOpenURL:(NSURL *)url;

//支付宝支付
- (void)alipayStartPay:(NSString *)orderStr;

//微信支付
- (void)wxPayStartPay:(WXReqModel *)reqModel;


@end


@interface WXReqModel : NSObject

@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *timestamp;

@end


