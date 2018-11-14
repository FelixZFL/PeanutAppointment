//
//  LoginViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "LoginViewController.h"
#import <WXApi.h>
#import "WXAuthModel.h"
#import "WXUserInfoModel.h"
#import "XMPPManager.h"
#import "LocationManager.h"

#import "BoundPhoneViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) WXUserInfoModel *userInfoModel;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *address;

@end

@implementation LoginViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
    
    [self addNotification];
    
    [[LocationManager sharedManager].locationManager requestLocationWithReGeocode:YES withNetworkState:NO completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        if (error) {
            
        } else {
            self.coordinate = location.location.coordinate;
            self.cityCode = location.rgcData.cityCode;
            self.address = location.rgcData.locationDescribe;
        }
    }];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    UIImageView *bgImageV = [[UIImageView alloc] initWithImage:imageNamed(@"login_bg")];
    [self.view addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setButtonStateNormalTitle:@"微信登录" Font:KFont(14) textColor:COLOR_UI_222222];
    loginBtn.backgroundColor = COLOR_UI_FFFFFF;
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_42);
    }];
    
}

- (void)setupNav {
    
    [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_back")];
    [self setTitle:@"登录"];
    [self.view bringSubviewToFront:self.customNavBar];
    [self.customNavBar setBackgroundAlpha:0];
    
}

#pragma mark - action

- (void)loginAction {
    if (self.cityCode.length > 0) {
        [self sendAuthRequest];
    } else {
        [[LocationManager sharedManager].locationManager requestLocationWithReGeocode:YES withNetworkState:NO completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
            if (error) {
                self.coordinate = CLLocationCoordinate2DMake(0, 0);
                self.cityCode = @"0";
                self.address = @"";
            } else {
                self.coordinate = location.location.coordinate;
                self.cityCode = location.rgcData.cityCode;
                self.address = location.rgcData.locationDescribe;
            }
            [self sendAuthRequest];
        }];
    }
}

#pragma mark - 发起微信登录授权

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"none";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}


- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeixinAuthResult:) name:NotificationName_WEIXIN_AUTH_BACK object:nil];
}

- (void)getWeixinAuthResult:(NSNotification *)notif {
    
    //获取授权
    SendAuthResp *response = notif.object;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeChatAppId,WeChatSecret,response.code];
    [YQNetworking getWithUrl:urlStr refreshRequest:NO cache:NO params:@{} progressBlock:nil successBlock:^(id response) {
        //{"errcode":40029,"errmsg":"invalid code"}
        if ([[response objectForKey:@"access_token"] length] > 0) {
            WXAuthModel *auth = [WXAuthModel mj_objectWithKeyValues:response];
            //获取用户信息
            NSString *userInfoUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",auth.access_token,auth.openid];
            [YQNetworking getWithUrl:userInfoUrlStr refreshRequest:NO cache:NO params:@{} progressBlock:nil successBlock:^(id response) {
                
                if ([[response objectForKey:@"openid"] length] > 0) {
                    WXUserInfoModel *user = [WXUserInfoModel mj_objectWithKeyValues:response];
                    NSLog(@"nickname == %@",user.nickname);
                    self.userInfoModel = user;
                    [[XMPPManager shareManager] registWithName:[NSString stringWithFormat:@"%@,%@",user.openid,user.nickname] registBlock:^(BOOL isSucess) {
                        [self requestToRegister];
                    }];
                }
            } failBlock:nil];
        }
    } failBlock:nil];
}
//age:年龄 （默认 18岁）
//sex：性别（1:男   2:女）
//addr：地址（中文）
- (void)requestToRegister {
    NSDictionary *param = @{@"wxNumber":self.userInfoModel.unionid,
                            @"nikeName":self.userInfoModel.nickname,
                            @"lon":@(self.coordinate.longitude),
                            @"lat":@(self.coordinate.latitude),
                            @"pushId":[PAUserDefaults getDeviceToken],
                            @"loginCity":self.cityCode,
                            @"openId":self.userInfoModel.openid,
                            @"chatAccount":[NSString stringWithFormat:@"%@,%@",self.userInfoModel.openid,self.userInfoModel.nickname],
                            @"age":@"18",
                            @"sex":@(self.userInfoModel.sex),
                            @"addr":self.address?:@""
                            };
    [YQNetworking postWithApiNumber:API_NUM_10012 params:param successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            //isPhone：（1:需要验证 0:不需要验证） userId = b83acbba2e854544a11090a157d3ece0;
            NSDictionary *dic = getResponseData(response);
            
            if ([[dic objectForKey:@"isPhone"] integerValue] == 1) {
                
                BoundPhoneViewController *vc = [[BoundPhoneViewController alloc] init];
                vc.userId = [dic objectForKey:@"userId"];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
                [PAUserDefaults saveUserId:[dic objectForKey:@"userId"]];
                [PAUserDefaults saveUserBoundPhone:[dic objectForKey:@"phone"]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
        
    } failBlock:^(NSError *error) {
        
    }];
}


#pragma mark - getter

@end
