//
//  SVProgressHUD+Extension.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/19.
//  Copyright © 2018 felix. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (Extension)

+ (void)showWithClearMaskType;

+ (void)dismissToMaskTypeNone;

@end

NS_ASSUME_NONNULL_END
