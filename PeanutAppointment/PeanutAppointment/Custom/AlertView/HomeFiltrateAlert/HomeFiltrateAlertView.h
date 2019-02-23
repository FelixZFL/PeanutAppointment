//
//  HomeFiltrateAlertView.h
//  PeanutAppointment
//
//  Created by felix on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseFiltrateBlock)(NSString *sex, NSString *age, NSString *distance);

NS_ASSUME_NONNULL_BEGIN

@interface HomeFiltrateAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithBlock:(ChooseFiltrateBlock)block;

@end

NS_ASSUME_NONNULL_END
