//
//  ShareViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ShareViewController.h"
#import "NavTypeChooseView.h"
#import "SGQRCode.h"

#import "WXApiObject.h"
#import <WXApi.h>
#import "TencentOpenAPI/QQApiInterface.h"

#define kBtnTag 948

@interface ShareViewController ()

@property (nonatomic, strong) NavTypeChooseView *navTitleView;
@property (nonatomic, assign) NavTypeChooseViewType type;

@property (nonatomic, strong) UIImageView *bgImageV;
@property (nonatomic, strong) UIImageView *QRCodeImgV;

@end

@implementation ShareViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.bgImageV = [[UIImageView alloc] initWithImage:imageNamed(@"share_bg_appointment")];
    [self.view addSubview:self.bgImageV];
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    
    CGFloat CodeImgWidth = ScreenWidth - 100;
    UIImageView *QRCodeImgV = [[UIImageView alloc] init];
    [self.view addSubview:QRCodeImgV];
    __weak __typeof(self)weakSelf = self;
    [QRCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.width.mas_equalTo(CodeImgWidth);
        make.height.mas_equalTo(CodeImgWidth);
    }];
    self.QRCodeImgV = QRCodeImgV;
    
    NSString *shareStr = shareAddressWithPhone([PAUserDefaults getUserBoundPhone]);
    
    QRCodeImgV.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:shareStr imageViewWidth:CodeImgWidth];
    
    
    CGFloat btnH = 69;
    
    UIView *shareView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self.view addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(btnH);
    }];
    
    
    NSArray *btnNameArr = @[@"QQ",@"微信",@"朋友圈"];
    NSArray *btnImageArr = @[@"share_btn_qq",@"share_btn_weichat",@"share_btn_friend"];
    
    CGFloat btnW = SCREEN_WIDTH/btnNameArr.count;
    
    for (int i = 0 ; i < btnNameArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnW, 0, btnW, btnH)];
        [btn setTitle:btnNameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateHighlighted];
        btn.titleLabel.font = KFont(12);
        [btn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBtnTag + i;
        [btn verticalImageAndTitle:MARGIN_5];
        [shareView addSubview:btn];
    }
    
}

- (void)setupNav {
    
    [self.customNavBar setTitleView:self.navTitleView];
    [self.view bringSubviewToFront:self.customNavBar];
    
}

#pragma mark - action

- (void)shareBtnAction:(UIButton *)sender {
    NSLog(@"tag==%ld",sender.tag - kBtnTag);
    
    NSString *titleStr = @"加入花生约见";
    UIImage *shareImage = self.QRCodeImgV.image;
    
    if (sender.tag - kBtnTag == 0) {
        NSData *imageData = UIImageJPEGRepresentation(shareImage, 0.5);
        QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imageData
                                                   previewImageData:imageData
                                                              title:titleStr
                                                        description:titleStr];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
        //将内容分享到qq
        QQApiSendResultCode code = [QQApiInterface sendReq:req];
        if (code == EQQAPITIMNOTSUPPORTAPI) {
            [SVProgressHUD showInfoWithStatus:@"请安装QQ"];
        }
        
    }else if (sender.tag - kBtnTag == 1 || sender.tag - kBtnTag == 2) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [documentPath stringByAppendingPathComponent:@"ocr.jpg"];
            NSData *imageData = UIImageJPEGRepresentation(shareImage, 1);
            [imageData writeToFile:filePath atomically:NO];
            
            UIImage *thumbImage = [UIImage imageWithData:UIImageJPEGRepresentation(shareImage, 0.5)];
            
            WXImageObject *ext = [WXImageObject object];
            // 小于10MB
            ext.imageData = imageData;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.mediaObject = ext;
            // 缩略图 小于32KB
            [message setThumbImage:thumbImage];
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = sender.tag - kBtnTag == 1 ? WXSceneSession : WXSceneTimeline;
            req.message = message;
            [WXApi sendReq:req];
        }else {
            [SVProgressHUD showErrorWithStatus:@"没有安装微信"];
        }
    }
    
}

#pragma mark - getter

- (NavTypeChooseView *)navTitleView {
    if (!_navTitleView) {
        _navTitleView = [[NavTypeChooseView alloc] initWithFrame:CGRectMake(0, 0, NavTypeChooseViewWidth, NavTypeChooseViewHeight)];
        [_navTitleView setleftBtnTitle:@"花生约见" rightBtnTitle:@"花生麻将"];
        self.type = NavTypeChooseViewType_left;
        [_navTitleView setType:NavTypeChooseViewType_left];
        __weak __typeof(self)weakSelf = self;
        [_navTitleView setNavTypeChooseBlock:^(NavTypeChooseViewType type) {
            NSLog(@"type---%lu",(unsigned long)type);
            weakSelf.type = type;
            if (type == NavTypeChooseViewType_left) {
                weakSelf.bgImageV.image = imageNamed(@"share_bg_appointment");
            } else {
                weakSelf.bgImageV.image = imageNamed(@"share_bg_majiang");
            }
        }];
    }
    return _navTitleView;
}



@end
