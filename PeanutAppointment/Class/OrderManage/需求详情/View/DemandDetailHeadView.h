//
//  DemandDetailHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemanDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface DemandDetailHeadView : UIView

@property (nonatomic, strong) DemanDetailModel *model;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
