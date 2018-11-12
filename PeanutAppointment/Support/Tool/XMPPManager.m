//
//  XMPPManager.m
//  PeanutAppointment
//
//  Created by felix on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "XMPPManager.h"
#import "AppDelegate.h"

static XMPPManager * _shareXMPPManager;

@interface XMPPManager ()

@end

@implementation XMPPManager

+ (XMPPManager*)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareXMPPManager = [[XMPPManager alloc] init];
        [_shareXMPPManager setupStream];
    });
    return _shareXMPPManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

#pragma mark -- strean setup

- (void)setupStream
{
    if (!_xmppStream) {
        _xmppStream = [[XMPPStream alloc] init];
        
        [self.xmppStream setHostName:XMPP_HOST];
        [self.xmppStream setHostPort:XMPP_PORT];
        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        [self.xmppStream setKeepAliveInterval:30];
        // 允许后台Socket运行.
        self.xmppStream.enableBackgroundingOnSocket=YES;
        
        // 3.好友模块 支持我们管理、同步、申请、删除好友
        //系统写好的XMPP存储对象
        //_rosterCoreDataStorage= [XMPPRosterCoreDataStorage sharedInstance];
        //_xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:_rosterCoreDataStorage dispatchQueue:dispatch_get_global_queue(0, 0)];
        _xmppRosterMemoryStorage = [[XMPPRosterMemoryStorage alloc] init];
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterMemoryStorage];
        
        [_xmppRoster activate:self.xmppStream];
        
        //同时给_xmppRosterMemoryStorage 和 _xmppRoster都添加了代理
        [_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
        //设置好友同步策略,XMPP一旦连接成功，同步好友到本地
        [_xmppRoster setAutoFetchRoster:YES]; //自动同步，从服务器取出好友
        //关掉自动接收好友请求，默认开启自动同意
        [_xmppRoster setAutoAcceptKnownPresenceSubscriptionRequests:NO];
        
        
        
        //接入断线重连模块
        _xmppReconnect = [[XMPPReconnect alloc] init];
        [_xmppReconnect setAutoReconnect:YES];
        [_xmppReconnect activate:self.xmppStream];
        
        //接入流管理模块
        _storage = [XMPPStreamManagementMemoryStorage new];
        _xmppStreamManagement = [[XMPPStreamManagement alloc] initWithStorage:_storage];
        _xmppStreamManagement.autoResume = YES;
        [_xmppStreamManagement activate:self.xmppStream];
        [_xmppStreamManagement addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //电子名片相关
        self.vCardCoreDataStorage = [XMPPvCardCoreDataStorage sharedInstance];
        self.vCardTempModule = [[XMPPvCardTempModule alloc]initWithvCardStorage:self.vCardCoreDataStorage];
        [self.vCardTempModule activate:self.xmppStream];
        [self.vCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
        self.vCardAvatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:self.vCardTempModule];
        [self.vCardAvatarModule activate:self.xmppStream];
        [self.vCardAvatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //接入消息模块 聊天记录管理
        _xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
        _xmppMessageArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_xmppMessageArchivingCoreDataStorage dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 9)];
        [_xmppMessageArchiving activate:self.xmppStream];
        [_xmppMessageArchiving addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        
    }
}


#pragma mark -- public
-(void)registWithName:(NSString *)userName registBlock:(RegistBlock )registBlock {
    self.type = XMPPManagerConnectType_Regist;
    self.registBlock = registBlock;
    [self connectToServerWintUser:userName];
}

- (void)loginWithName:(NSString *)userName loginBlock:(LoginBlock)loginBlock {
    self.type = XMPPManagerConnectType_Login;
    self.loginBlock = loginBlock;
    [self connectToServerWintUser:userName];
}

//与服务器的建立链接
-(void)connectToServerWintUser:(NSString *)name{
    
    // 不管登陆几次,每次登陆之前都要先把连接断开
    [_xmppStream disconnect];
    
    // 初始化XMPPPStream
    [self setupStream];
    
    //_myJID = [XMPPJID jidWithUser:userName domain:XMPP_DOMAIN resource:XMPP_Resource];
    _myJID = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@", name, XMPP_DOMAIN, XMPP_Resource]];
    
    [self.xmppStream setMyJID:_myJID];
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        [SVProgressHUD showErrorWithStatus:@"Error connecting"];
    }
    
}

-(void)logOut
{
    [self goOffline];
    [_xmppStream disconnectAfterSending];
}


- (void)goOnline
{
    XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    [[self xmppStream] sendElement:presence];
}

- (void)sendMessage:(NSString *)message to:(XMPPJID *)jid
{
    XMPPMessage* newMessage = [[XMPPMessage alloc] initWithType:@"chat" to:jid];
    [newMessage addBody:message];
    [_xmppStream sendElement:newMessage];
}

- (void)sendMessage:(NSString *)message toName:(NSString *)name {
    XMPPJID *jid = [XMPPJID jidWithUser:name domain:XMPP_DOMAIN resource:XMPP_Resource];
//    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@", name, XMPP_DOMAIN, XMPP_Resource]];

    [self sendMessage:message to:jid];
}

//添加好友
- (void)XMPPAddFriendSubscribe:(NSString *)name  {
    //XMPP_DOMAIN 就是服务器名，  主机名
    XMPPJID *jid = [XMPPJID jidWithUser:name domain:XMPP_DOMAIN resource:XMPP_Resource];
//    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@", name, XMPP_DOMAIN, XMPP_Resource]];
//    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name,XMPP_DOMAIN]];
    
    [_xmppRoster subscribePresenceToUser:jid];
}

//删除好友，name为好友账号
- (void)XMPPRemoveFriendBuddy:(NSString *)name {
//    XMPPJID *jid = [XMPPJID jidWithUser:name domain:XMPP_DOMAIN resource:XMPP_Resource];
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@/%@", name, XMPP_DOMAIN, XMPP_Resource]];

    [_xmppRoster removeUser:jid];
}


#pragma mark -- connect delegate

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
    NSLog(@"%s",__func__);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    
    NSError *error = nil;
    if (self.type == XMPPManagerConnectType_Login) {
        // 发送登陆密码
        if (![[self xmppStream] authenticateWithPassword:xmppCommonPassword error:&error]) {
            NSLog(@"Error authenticating: %@", error);
        }
    } else {
        // 发送注册密码
        if (![[self xmppStream] registerWithPassword:xmppCommonPassword error:&error]) {
            NSLog(@"Error authenticating: %@", error);
        }
    }
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"%s",__func__);
}

#pragma mark -- 登录验证回调
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"%s",__func__);
    NSLog(@"登录成功");
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    if (self.loginBlock) {
        self.loginBlock(YES);
        self.loginBlock = nil;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DIDLogIn" object:nil];
    
    [self goOnline];
    
    //启用流管理
    [_xmppStreamManagement enableStreamManagementWithResumption:YES maxTimeout:0];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
    NSLog(@"%s",__func__);
    NSLog(@"登录失败");
    [SVProgressHUD showErrorWithStatus:@"登录失败"];
    if (self.loginBlock) {
        self.loginBlock(NO);
        self.loginBlock = nil;
    }
}

#pragma mark -- 注册回调
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
    if (self.registBlock) {
        self.registBlock(YES);
        self.registBlock = nil;
    }
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error{
    NSLog(@"注册失败");
    if (self.registBlock) {
        self.registBlock(NO);
        self.registBlock = nil;
    }
}

#pragma mark -- 收到添加好友的请求
/** 收到出席订阅请求（代表对方想添加自己为好友) */
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence {
    //取得好友状态
    NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]];
    //online/offline
    //请求的用户
    NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
    NSLog(@"presenceType:%@",presenceType);
    NSLog(@"presence2:%@  sender2:%@",presence,sender);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"收到好友请求" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        XMPPJID *jid = [XMPPJID jidWithString:presenceFromUser];
        //接收添加好友请求
        [_xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    }]];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    //同意并添加对方为好友
    //    [self.xmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
    //拒绝的方法
    //    [self.xmppRoster rejectPresenceSubscriptionRequestFrom:presence.from];
}

#pragma mark -- XMPPMessage Delegate


- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"%s--%@",__func__,message);
}

- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"%s--%@",__FUNCTION__, message);
}

- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSLog(@"%s--%@",__FUNCTION__, message);
}


#pragma mark -- Roster

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"%s--%@",__FUNCTION__, presence);
    //对方上线或离线,更新状态
    if ([presence.type isEqualToString:@"unsubscribe"]) {//收到对方取消定阅我得消息
        //从我的本地通讯录中将他移除
        [self.xmppRoster removeUser:presence.from];
    }
}

- (void)xmppRosterDidChange:(XMPPRoster *)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RosterChanged" object:nil];
    [self rosterChange];
}

- (void)rosterChange
{
    //从存储器中取出我得好友数组，更新数据源
    NSMutableArray *contacts = [NSMutableArray arrayWithArray:_xmppRosterMemoryStorage.unsortedUsers];
    NSLog(@"count == %ld",contacts.count);
}


/**
 * 同步结束
 **/
//收到好友列表IQ会进入的方法，并且已经存入我的存储器
- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:kXMPP_ROSTER_CHANGE object:nil];
}

#pragma mark ===== 文件接收=======

//是否同意对方发文件
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didReceiveSIOffer:(XMPPIQ *)offer
{
    NSLog(@"%s",__FUNCTION__);
    [self.xmppIncomingFileTransfer acceptSIOffer:offer];
}

//存储文件 音频为amr格式  图片为jpg格式
- (void)xmppIncomingFileTransfer:(XMPPIncomingFileTransfer *)sender didSucceedWithData:(NSData *)data named:(NSString *)name
{
    NSLog(@"xmppIncomingFileTransfer ---sender ===  %@",sender);
//    XMPPJID *jid = [sender.senderJID copy];
//    NSString *subject;
//    NSString *extension = [name pathExtension];
//    if ([@"amr" isEqualToString:extension]) {
//        subject = @"voice";
//    }else if([@"jpg" isEqualToString:extension]){
//        subject = @"picture";
//    }
//
//    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:jid];
//
//    [message addAttributeWithName:@"from" stringValue:sender.senderJID.bare];
//    [message addSubject:subject];
//
//    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    path = [path stringByAppendingPathComponent:[XMPPStream generateUUID]];
//    path = [path stringByAppendingPathExtension:extension];
//    [data writeToFile:path atomically:YES];
//
//    [message addBody:path.lastPathComponent];
//
//    [self.xmppMessageArchivingCoreDataStorage archiveMessage:message outgoing:NO xmppStream:self.xmppStream];
}


#pragma mark -- terminate
/**
 *  申请后台时间来清理下线的任务
 */
-(void)applicationWillTerminate
{
    UIApplication *app=[UIApplication sharedApplication];
    UIBackgroundTaskIdentifier taskId;
    
    taskId=[app beginBackgroundTaskWithExpirationHandler:^(void){
        [app endBackgroundTask:taskId];
    }];
    
    if(taskId==UIBackgroundTaskInvalid){
        return;
    }
    
    //只能在主线层执行
    [_xmppStream disconnectAfterSending];
}


@end
