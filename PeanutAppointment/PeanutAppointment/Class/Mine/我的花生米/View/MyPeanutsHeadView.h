//
//  MyPeanutsHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyPeanutsListModel;
NS_ASSUME_NONNULL_BEGIN

@interface MyPeanutsHeadView : UIView

+ (CGFloat )getHeight;

- (void)updateWithModel:(MyPeanutsListModel *)model;

@end

NS_ASSUME_NONNULL_END
