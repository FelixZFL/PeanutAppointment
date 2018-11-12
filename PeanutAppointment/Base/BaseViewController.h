//
//  BaseViewController.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomNavigationBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) CustomNavigationBar *customNavBar;

- (void)back;

- (void)setNavStyle:(CustomNavStyle)navStyle;

@end
