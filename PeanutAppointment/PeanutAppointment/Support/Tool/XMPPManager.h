//
//  XMPPManager.h
//  PeanutAppointment
//
//  Created by felix on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <XMPPFramework/XMPPFramework.h>

/*
 #define XMPP_HOST     @"39.107.76.196"
 #define XMPP_PORT     5222
 //#define XMPP_DOMAIN   @"localhost"
 //#define XMPP_DOMAIN   @"127.0.0.1"
 #define XMPP_DOMAIN   @"39.107.76.196"
 
 #define XMPP_Resource @"iOS"
 
 typedef void(^RegistBlock)(BOOL isSucess);
 typedef void(^LoginBlock)(BOOL isSucess);
 
 typedef enum : NSUInteger {
 XMPPManagerConnectType_Login,
 XMPPManagerConnectType_Regist,
 } XMPPManagerConnectType;
 */

@interface XMPPManager : NSObject

/////xmpp基础服务类
//@property (nonatomic, strong) XMPPStream *xmppStream;
//
///// 如果失去连接,自动重连
//@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
//
//@property (nonatomic, copy) RegistBlock registBlock;
//@property (nonatomic, copy) LoginBlock loginBlock;
//@property (nonatomic, assign) XMPPManagerConnectType type;
//
//@property (nonatomic, strong)   XMPPJID *myJID;
//
/////好友列表类
//@property (nonatomic, strong) XMPPRoster *xmppRoster;
/////好友列表（用户账号）在core data中的操作类
////@property (nonatomic, strong) XMPPRosterCoreDataStorage *rosterCoreDataStorage;
//@property (nonatomic, strong) XMPPRosterMemoryStorage *xmppRosterMemoryStorage;
//
//
//@property(nonatomic,strong)XMPPStreamManagementMemoryStorage *storage;
//@property(nonatomic,strong)XMPPStreamManagement *xmppStreamManagement;
//
///**
// 电子名片相关
// */
//@property(nonatomic,strong)XMPPvCardTempModule *vCardTempModule;
//@property(nonatomic,strong)XMPPvCardCoreDataStorage *vCardCoreDataStorage;
//@property(nonatomic,strong)XMPPvCardAvatarModule *vCardAvatarModule;
//
//
//@property (nonatomic, strong) XMPPIncomingFileTransfer *xmppIncomingFileTransfer;
//
/////聊天信息模块
//@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchiving;
/////聊天信息在数据库中的操作类
//@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
//
//+ (XMPPManager*)shareManager;
//
//
///**
// 注册
//
// @param userName 用户名
// @param registBlock 注册回调
// */
//- (void)registWithName:(NSString *)userName registBlock:(RegistBlock )registBlock;
//
//
///**
// 登陆
//
// @param userName 用户名: user
// @param loginBlock 登陆回调
// */
//- (void)loginWithName:(NSString *)userName loginBlock:(LoginBlock)loginBlock;
//
///**
// *  退出登录
// */
//- (void)logOut;
//
///**
// *  上线
// */
//- (void)goOnline;
//
///**
// *  下线
// */
//- (void)goOffline;
//
///**
// *  发送消息
// *
// *  @param message 消息内容
// *  @param jid     发送对方的ID
// */
//- (void)sendMessage:(NSString *)message to:(XMPPJID *)jid;
//
//- (void)sendMessage:(NSString *)message toName:(NSString *)name;
//
///**
// 添加好友
//
// @param name 用户名
// */
//- (void)XMPPAddFriendSubscribe:(NSString *)name;
//
///**
// 删除好友
//
// @param name 用户名
// */
//- (void)XMPPRemoveFriendBuddy:(NSString *)name;




@end
