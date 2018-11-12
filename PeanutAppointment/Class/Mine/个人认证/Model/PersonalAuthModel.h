//
//  PersonalAuthModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/28.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalAuthModel : NSObject

///技能认证(1：已认证 0：未认证)
@property (nonatomic, copy) NSString *isCertification;
///手机号
@property (nonatomic, copy) NSString *phone;
///身份证认证(0：未认证/1：已认证/2：待审核/3：审核失败)
@property (nonatomic, copy) NSString *idCard;
///支付宝账号
@property (nonatomic, copy) NSString *aliPayNumber;
///微信账号
@property (nonatomic, copy) NSString *wxNumber;


/*
 "isCertification": "1", //技能认证(1：已认证 0：未认证)
 "phone": "13677697947",//手机号
 "idCard": 1, //身份证认证(0：未认证/1：已认证/2：待审核/3：审核失败)
 "aliPayNumber": "13677697947",//支付宝账号
 "wxNumber": "13677697947"//微信账号
 */

@end

NS_ASSUME_NONNULL_END
