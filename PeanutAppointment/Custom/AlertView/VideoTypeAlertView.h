//
//  VideoTypeAlertView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/13.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^BtnClcikBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface VideoTypeAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithBlock:(BtnClcikBlock )block;

@end

NS_ASSUME_NONNULL_END
