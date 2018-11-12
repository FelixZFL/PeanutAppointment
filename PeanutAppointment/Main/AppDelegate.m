//
//  AppDelegate.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JPush.h"
#import "PayManager.h"

#import <WXApi.h>
#import <TencentOpenAPI/TencentApiInterface.h>//qq
#import <TencentOpenAPI/TencentOAuth.h>//qq
#import <BMKLocationkit/BMKLocationComponent.h>//百度地图



#import "RootViewController.h"
//#import "LoginViewController.h"
//#import "NewFeatureViewController.h"

@interface AppDelegate ()<WXApiDelegate,TencentSessionDelegate,BMKLocationAuthDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //SVProgressHUD 设置默认最短显示时间
    [SVProgressHUD setMinimumDismissTimeInterval:2.f];
    
    //微信
    [WXApi registerApp:WeChatAppId];
    
    //注册极光
    [self setStartJPUSHServiceWithOptions:launchOptions];
    
    //qq
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentOAuthID andDelegate:self];
    NSLog(@"TencentOAuth--%@",tencentOAuth);
    
    //百度定位
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BaiDuAppKey authDelegate:self];
    
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //初始化界面
    [self initWindow];
    
    return YES;
}

#pragma mark - 界面跳转

- (void)initWindow {
    [PAUserDefaults saveAppReseted:YES];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //获取当前版本号 与存储的新特性版本号对比
    NSString *currentVersion = kCurrentShortVersion;
    if ([currentVersion compare:[PAUserDefaults getVersionOfNewFeature]] == NSOrderedDescending) {
        //保存版本号
        [PAUserDefaults saveVersionOfNewFeature:currentVersion];
    }
    [self enterRootVC];
}

- (void)enterRootVC {
    RootViewController *vc = [[RootViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

//- (void)enterLoginVC {
//    [ANGUserDefaults logout];
//    LoginViewController *vc = [[LoginViewController alloc] init];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
//}
//

//- (void)enterNewFeatureVC {
//    NewFeatureViewController * vc =[[NewFeatureViewController alloc] init];
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];
//}

#pragma mark - 推送 -

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self JPapplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self JPapplication:application didFailToRegisterForRemoteNotificationsWithError:error];
}

#pragma mark - 与其他应用互动 -

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%s",__func__);
    [self JPapplicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s",__func__);
    [self JPapplicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%s",__func__);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    
    [[PayManager sharedManager] processOrderWithPaymentResultWithOpenURL:url];
    [WXApi handleOpenURL:url delegate:self];
    [TencentOAuth HandleOpenURL:url];
    
    return YES;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        //ERR_OK = 0(用户同意) ERR_AUTH_DENIED = -4（用户拒绝授权） ERR_USER_CANCEL = -2（用户取消）
        //code    用户换取access_token的code，仅在ErrCode为0时有效
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_WEIXIN_AUTH_BACK object:resp];
    } else {
        
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        NSString *strTitle;
        
        if([resp isKindOfClass:[SendMessageToWXResp class]])
        {
            strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        }
        if([resp isKindOfClass:[PayResp class]]){
            //支付返回结果，实际支付结果需要去微信服务器端查询
            strTitle = [NSString stringWithFormat:@"支付结果"];
            
            switch (resp.errCode) {
                    case WXSuccess:{
                        strMsg = @"支付结果：成功！";
                        NSDictionary *dic = @{@"type":@"wx",@"status":@"1"};
                        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
                        break;
                    }
                default:{
                    strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                    NSDictionary *dic = @{@"type":@"wx",@"status":@"0"};
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName_PAY_RESULT object:dic];
                    break;
                }
            }
        }
        NSLog(@"strMsg--%@",strMsg);
        NSLog(@"strTitle---%@",strTitle);
    }
}


#pragma mark - TencentSessionDelegate 消除警告 不需要实现
- (void)tencentDidLogin {}
- (void)tencentDidNotLogin:(BOOL)cancelled{}
- (void)tencentDidNotNetWork{}

#pragma mark - BMKLocationAuthDelegate
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    if (0 == iError) {
        NSLog(@"[Baidu-Map] 授权成功");
    } else {
        NSLog(@"[Baidu-Map] moulde offline. Reason %ld",iError);
    }
}

@end
