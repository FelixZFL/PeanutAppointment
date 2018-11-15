//
//  UserMainPageModel.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserMainPageUserInfoModel,UserMainPagePhotoListModel,UserMainPageSkillListModel,UserMainPageSkillInfoModel,UserMainPageAccessListModel;


NS_ASSUME_NONNULL_BEGIN

@interface UserMainPageModel : NSObject

///个人信息
@property (nonatomic, strong) UserMainPageUserInfoModel *userInfo;
///相册list
@property (nonatomic, strong) NSArray<UserMainPagePhotoListModel *> *phontList;
///技能列表
@property (nonatomic, strong) NSArray<UserMainPageSkillListModel *> *skillList;
///技能信息
@property (nonatomic, strong) UserMainPageSkillInfoModel *skillInfo;
///访问list
@property (nonatomic, strong) NSArray<UserMainPageAccessListModel *> *accessList;


/*
 "userInfo": {
 },
 "phontList": [{ //相册list
 "photosUrl": "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539576165754&di=b6312f0b638e7e16d96edeb9bb8da7cf&imgtype=0&src=http://img17.3lian.com/d/file/201703/07/fc03b55448ee1e068c7132007c80abc2.jpg"
 }],
 "skillList": [{ //技能列表
 "pusId": "1", //技能id
 "jnName": "测试" //技能名称
 }],
 "skillInfo": {

 },
 "accessList": [{ //访问list
 "puId": "2", //用户id
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg" //头像
 }]
 
 */

@end

NS_ASSUME_NONNULL_END

@interface UserMainPageUserInfoModel : NSObject

///距离 单位KM
@property (nonatomic, copy) NSString *distance;
///1：实名认证
@property (nonatomic, copy) NSString *isCertification;
///手机号
@property (nonatomic, copy) NSString *phone;
///1：男 2：女
@property (nonatomic, copy) NSString *sex;
///头像
@property (nonatomic, copy) NSString *headUrl;
///昵称
@property (nonatomic, copy) NSString *nikeName;
///地理位置
@property (nonatomic, copy) NSString *addr;
///支付宝账号
@property (nonatomic, copy) NSString *aliPayNumber;
///年龄
@property (nonatomic, copy) NSString *age;
///点赞数量
@property (nonatomic, copy) NSString *likeSumNumber;
///微信账号
@property (nonatomic, copy) NSString *wxNumber;

/*
 "distance",10, //距离 单位KM
 "isCertification": "1", //1：实名认证
 "phone": "13677697947", //手机号
 "sex": "1", //1：男 2：女
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg", //头像
 "nikeName": "梁大爷", //昵称
 "addr": "重庆市沙坪坝", //地理位置
 "aliPayNumber": "13677697947", //支付宝账号
 "age": 22, //年龄
 "likeSumNumber": 22, //点赞数量
 "wxNumber": "13677697947" //微信账号
 */

@end


@interface UserMainPagePhotoListModel : NSObject

///图片地址
@property (nonatomic, copy) NSString *photosUrl;

/*
 "photosUrl": "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539576165754&di=b6312f0b638e7e16d96edeb9bb8da7cf&imgtype=0&src=http://img17.3lian.com/d/file/201703/07/fc03b55448ee1e068c7132007c80abc2.jpg"
 */

@end


@interface UserMainPageSkillListModel : NSObject

///技能id
@property (nonatomic, copy) NSString *pusId;
///技能名称
@property (nonatomic, copy) NSString *jnName;

/*
 "pusId": "1", //技能id
 "jnName": "测试" //技能名称
 */

@end


@interface UserMainPageSkillInfoModel : NSObject

///服务方式
@property (nonatomic, copy) NSString *serviceType;
///服务价格
@property (nonatomic, copy) NSString *servicePrice;
///技能介绍
@property (nonatomic, copy) NSString *introduce;
///服务定金
@property (nonatomic, copy) NSString *downPayment;
///服务介绍
@property (nonatomic, copy) NSString *selfIntroduction;
///服务经历
@property (nonatomic, copy) NSString *experience;
///服务时间
@property (nonatomic, copy) NSString *serviceTime;



/*
 "serviceType": "1", //服务方式
 "servicePrice": 20, //服务价格
 "introduce": "服务好", //技能介绍
 "downPayment": 20,//服务定金
 "selfIntroduction": "专业的技能服务", //服务介绍
 "experience": "给大型公司服务过", //服务经理
 "serviceTime": "1,2,3,4,5,6,7" //服务时间
 */

@end


@interface UserMainPageAccessListModel : NSObject

///用户id
@property (nonatomic, copy) NSString *puId;

///头像
@property (nonatomic, copy) NSString *headUrl;

/*
 "puId": "2",
 "headUrl": "http://imagexb.test.upcdn.net/xbsc/user/1523174557774.jpg"
 */

@end
