//
//  MaJiangRoomCardFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MajiangRoomCardModel;

NS_ASSUME_NONNULL_BEGIN

@interface MaJiangRoomCardFootView : UIView

@property (nonatomic, copy) void(^itemClickBlock) (MajiangRoomCardModel *model);

@property (nonatomic, strong) NSArray<MajiangRoomCardModel *> *dataArray;

+ (CGFloat )getHeightWithDadaArray:(NSArray<MajiangRoomCardModel *> *)dataArray;

@end

NS_ASSUME_NONNULL_END
