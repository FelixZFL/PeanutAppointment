//
//  ReleaseOrderFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReleaseOrderUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseOrderFootView : UIView

@property (nonatomic, copy) void (^btnClickBlcok) (NSInteger index);

+ (CGFloat)getHeightWithArray:(NSArray *)array;

@property (nonatomic, strong) NSArray<ReleaseOrderUserModel *> *array;

@end

NS_ASSUME_NONNULL_END
