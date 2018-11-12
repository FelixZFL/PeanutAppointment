//
//  RewardAlertHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RewardModel;

NS_ASSUME_NONNULL_BEGIN

@interface RewardAlertHeadView : UIView

@property (nonatomic, copy) void(^chooseGiftChangedBlcok) (NSInteger giftCount);

- (void)updateWithModel:(RewardModel *)model;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
