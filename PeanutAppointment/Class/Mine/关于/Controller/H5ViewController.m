//
//  H5ViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "H5ViewController.h"

#import "SGWebView.h"

@interface H5ViewController ()<SGWebViewDelegate>

@property (nonatomic , strong) SGWebView *webView;


@end

@implementation H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
}

- (void)setupUI {
    // 添加webView
    CGFloat webViewX = 0;
    CGFloat webViewY = NAVITETION_HEIGHT;
    CGFloat webViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webViewH = SCREEN_HEIGHT - NAVITETION_HEIGHT;
    self.webView = [SGWebView webViewWithFrame:CGRectMake(webViewX, webViewY, webViewW, webViewH)];
    if ([self.jump_URL hasPrefix:@"http"]) {
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.jump_URL]]];
    }else {
        [_webView loadHTMLString:self.jump_URL];
    }
    _webView.SGQRCodeDelegate = self;
    [self.view addSubview:_webView];
}

#pragma mark - SGWebViewDelegate

- (void)webView:(SGWebView *)webView didFinishLoadWithURL:(NSURL *)url {
    NSLog(@"didFinishLoad");
    [self setTitle:webView.navigationItemTitle];
}

@end
