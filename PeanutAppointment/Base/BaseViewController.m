//
//  BaseViewController.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CustomNavStyle stateStyle;

@property (nullable, nonatomic, weak) id <UIGestureRecognizerDelegate> delegate;

@end

@implementation BaseViewController

#pragma mark - lifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = COLOR_UI_F0F0F0;

    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.customNavBar];
    
    //更新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
    if (self.navigationController.viewControllers.count > 1) {
        [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_back")];
    }
    
    [self setNavStyle:CustomNavStyle_Light];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) { // 记录系统返回手势的代理
        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;// 设置系统返回手势的代理为当前控制器
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];//设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.count <= 1) {
        //关闭ios右滑返回
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.delegate=self;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.navigationController.viewControllers.count <= 1) {
        //开启ios右滑返回
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}


#pragma mark - public -

- (void)setTitle:(NSString *)title {
    [self.customNavBar setTitle:title];
}


- (void)setNavStyle:(CustomNavStyle)navStyle {
    
    //更新导航栏
    [self.customNavBar setNavStyle:navStyle];
    
    if (self.navigationController.childViewControllers.count != 1) {
        if (navStyle == CustomNavStyle_Default) {
            [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_back_black")];
        }else if (navStyle == CustomNavStyle_Light) {
            [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_back")];
        }
    }
    //
    [self setStateStyle:navStyle];
}

-(void)setStateStyle:(CustomNavStyle)stateStyle {
    _stateStyle = stateStyle;
    //更新状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - action -
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.stateStyle == CustomNavStyle_Light) {
        return UIStatusBarStyleLightContent;
    }else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.childViewControllers.count > 1) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - getter -

- (CustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [CustomNavigationBar CustomNavBar];
        [_customNavBar setBottomLineHidden:YES];
    }
    return _customNavBar;
}

@end
