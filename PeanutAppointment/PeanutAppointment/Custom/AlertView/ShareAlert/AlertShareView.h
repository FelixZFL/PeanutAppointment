//
//  AlertShareView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShareDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface AlertShareView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithModel:(ShareDataModel *)model;
//+ (instancetype )alert;
@end

NS_ASSUME_NONNULL_END
