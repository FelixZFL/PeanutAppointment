//
//  CommentListAlertView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentListAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithId:(NSString *)pusId;

@end

NS_ASSUME_NONNULL_END
