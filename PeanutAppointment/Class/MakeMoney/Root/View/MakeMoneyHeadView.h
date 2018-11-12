//
//  MakeMoneyHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MakeMoneyHeadView : UIView

@property (nonatomic, copy) void(^buttonClickBlock) (NSInteger index);

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
