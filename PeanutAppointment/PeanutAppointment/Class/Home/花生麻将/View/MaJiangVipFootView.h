//
//  MaJiangVipFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MajiangVipModel;

NS_ASSUME_NONNULL_BEGIN

@interface MaJiangVipFootView : UIView

@property (nonatomic, copy) void(^itemClickBlock) (MajiangVipModel *model);

@property (nonatomic, strong) NSArray<MajiangVipModel *> *dataArray;

+ (CGFloat )getHeightWithDadaArray:(NSArray<MajiangVipModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
