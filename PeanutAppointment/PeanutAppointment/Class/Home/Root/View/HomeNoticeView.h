//
//  HomeNoticeView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeNoticeListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeNoticeView : UIView

@property (nonatomic, strong) NSArray<HomeNoticeListModel *> *array;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
