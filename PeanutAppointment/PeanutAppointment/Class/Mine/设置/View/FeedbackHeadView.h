//
//  FeedbackHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceholderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackHeadView : UIView

@property (nonatomic, strong) CustomPlaceholderTextView *feedBackTextView;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
