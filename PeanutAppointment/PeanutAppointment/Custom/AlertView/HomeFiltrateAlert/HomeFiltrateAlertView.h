//
//  HomeFiltrateAlertView.h
//  PeanutAppointment
//
//  Created by felix on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseIndexBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface HomeFiltrateAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype )alertWithBlock:(ChooseIndexBlock)block;

@end

NS_ASSUME_NONNULL_END
