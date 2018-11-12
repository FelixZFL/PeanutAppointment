//
//  UIViewController+FLExtension.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FLExtension)


- (void)fl_toLastViewController;

+ (UIViewController*)fl_currentViewController;

+ (UIViewController*)fl_currentViewControllerFrom:(UIViewController*)viewController;


@end
