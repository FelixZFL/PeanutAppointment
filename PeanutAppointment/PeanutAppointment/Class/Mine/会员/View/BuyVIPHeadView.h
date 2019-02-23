//
//  BuyVIPHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyVIPModel;

NS_ASSUME_NONNULL_BEGIN

@interface BuyVIPHeadView : UIView

@property (nonatomic, copy) void(^chooseBlock)(BuyVIPModel *model);

+ (CGFloat )getHeightWithArray:(NSArray <BuyVIPModel *>*)array;

- (void)updateWithArray:(NSArray <BuyVIPModel *>*)array;

@end

NS_ASSUME_NONNULL_END
