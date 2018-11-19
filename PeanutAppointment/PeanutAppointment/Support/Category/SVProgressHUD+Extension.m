//
//  SVProgressHUD+Extension.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/19.
//  Copyright © 2018 felix. All rights reserved.
//

#import "SVProgressHUD+Extension.h"

@implementation SVProgressHUD (Extension)

+ (void)showWithClearMaskType {
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self show];
}

+ (void)dismissToMaskTypeNone{
    [self dismiss];
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

@end
