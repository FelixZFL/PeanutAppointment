//
//  RootViewController.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RootViewController.h"

#import "BaseNavigationController.h"

#import "HomeViewController.h"//首页
#import "AppointmentOrderViewController.h"//去约单
#import "OrderManageViewController.h"//订单管理
#import "MakeMoneyViewController.h"//去挣钱
#import "MineViewController.h"//个人中心

#import "LoginViewController.h"//登录


@interface RootViewController ()<UITabBarControllerDelegate>

@end

@implementation RootViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadUserViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- public -

- (void)logoutToHomePage {
    if (self.selectedIndex == 0) {
        [[[self topViewController] navigationController] popViewControllerAnimated:YES];
    }else {
        //获取当前的nav
        UINavigationController *nav = [[self topViewController] navigationController];
        self.selectedIndex = 0;
        [nav popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - private
- (void)loadUserViewControllers {
    
    //******  首页  ****** //
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    //******  去约单  ****** //
    AppointmentOrderViewController *aoVC = [[AppointmentOrderViewController alloc] init];
    // ******  订单管理  ****** //
    OrderManageViewController *omVC = [[OrderManageViewController alloc] init];
    // ******  去挣钱  ****** //
    MakeMoneyViewController *mmVC = [[MakeMoneyViewController alloc] init];
    // ******  个人中心  ****** //
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    self.viewControllers = @[[self controllerWithController:homeVC title:@"首页" tag:1001 normalImageName:@"main_tabbar_home_normal" selectedImageName:@"main_tabbar_home_selected"],
                             [self controllerWithController:aoVC title:@"去约单" tag:1002 normalImageName:@"main_tabbar_appointmentOrder_normal" selectedImageName:@"main_tabbar_appointmentOrder_selected"],
                             [self controllerWithController:omVC title:@"订单管理" tag:1003 normalImageName:@"main_tabbar_orderManager_normal" selectedImageName:@"main_tabbar_orderManager_selected"],
                             [self controllerWithController:mmVC title:@"去挣钱" tag:1004 normalImageName:@"main_tabbar_makeMoney_normal" selectedImageName:@"main_tabbar_makeMoney_selected"],
                             [self controllerWithController:mineVC title:@"个人中心" tag:1005 normalImageName:@"main_tabbar_mine_normal" selectedImageName:@"main_tabbar_mine_selected"]];
    self.delegate = self;
    self.selectedIndex = 0;
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    // 未选中状态的标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:COLOR_UI_666666} forState:UIControlStateNormal];
    
    // 选中状态的标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:COLOR_UI_THEME_RED} forState:UIControlStateSelected];
    
}

-(BaseNavigationController * )controllerWithController:(UIViewController *)controller
                                                 title:(NSString*)title
                                                   tag:(NSInteger)tag
                                       normalImageName:(NSString*)normalImageName
                                     selectedImageName:(NSString*)selectedImageName
{
    
    controller.tabBarItem.tag           = tag;
    controller.tabBarItem.title         = title;
    controller.tabBarItem.image         = [ [UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [ [UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return [[BaseNavigationController alloc] initWithRootViewController:controller];
}



#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (![PATool isLogin]) {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];

        return NO;
    }
    
    return YES;
}



@end
