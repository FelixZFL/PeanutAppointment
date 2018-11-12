//
//  VersionUpdateAlertView.h
//  shopping
//
//  Created by XB on 2018/5/2.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VersionModel;

@interface VersionUpdateAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithModel:(VersionModel *)model ;

@end
 
 
