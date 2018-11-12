//
//  PayManager.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PayManager.h"


#import <AlipaySDK/AlipaySDK.h>

#import <WXApi.h>


@implementation PayManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static PayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[PayManager alloc] init];
    });
    return instance;
}


#pragma mark ----------------处理------------------------
- (void)processOrderWithPaymentResultWithOpenURL:(NSURL *)url{
    
    //  跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"支付宝支付：%@",resultDic);
        if([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
            NSDictionary *dic = @{@"type":@"alipay",@"status":@"1"};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
        }else {
            NSDictionary *dic = @{@"type":@"alipay",@"status":@"0"};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
        }
    }];
    
}

- (void)alipayStartPay:(NSString *)orderStr
{
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        //查询支付结果
        NSLog(@"Alipay reslut = %@",resultDic);
        if([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
            NSDictionary *dic = @{@"type":@"alipay",@"status":@"1"};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
        }else {
            NSDictionary *dic = @{@"type":@"alipay",@"status":@"0"};
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
        }
    }];
}


//微信发起支付请求

- (void)wxPayStartPay:(WXReqModel *)reqModel {
    
    PayReq *wxreq             = [[PayReq alloc] init];
    wxreq.openID              = reqModel.appid;
    wxreq.partnerId           = reqModel.partnerid;
    wxreq.prepayId            = reqModel.prepayid;
    wxreq.nonceStr            = reqModel.noncestr;
    wxreq.timeStamp           = reqModel.timestamp.intValue;
    wxreq.package             = reqModel.package;//@"Sign=WXPay"
    wxreq.sign                = reqModel.sign;
    [WXApi sendReq:wxreq];
    
}

@end

@implementation WXReqModel

@end


