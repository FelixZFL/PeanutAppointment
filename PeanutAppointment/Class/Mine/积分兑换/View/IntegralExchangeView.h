//
//  IntegralExchangeView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntegralExchangeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface IntegralExchangeView : UIView

+ (CGFloat )getHeightWithArray:(NSArray<IntegralExchangeListModel *> *)dataArr;

@property (nonatomic, strong) NSMutableArray<IntegralExchangeListModel *> *dataArr;

@property (nonatomic, copy) void(^chooseBlock) (IntegralExchangeListModel *model);

@end

NS_ASSUME_NONNULL_END
