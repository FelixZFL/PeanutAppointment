//
//  ReleaseOrderHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReleaseOrderUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface ReleaseOrderHeadView : UIView

@property (nonatomic, copy) void (^chooseBlock) (BOOL isLike ,ReleaseOrderUserModel *model);

@property (nonatomic, strong, nullable) ReleaseOrderUserModel *model;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
