//
//  FeedbackViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum : NSUInteger {
    FeedbackViewType_feedback,//反馈意见
    FeedbackViewType_report,//举报
} FeedbackViewType;

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackViewController : BaseTableViewController

@property (nonatomic, assign) FeedbackViewType type;

@end

NS_ASSUME_NONNULL_END
