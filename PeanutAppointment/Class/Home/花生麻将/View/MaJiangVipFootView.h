//
//  MaJiangVipFootView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaJiangVipFootView : UIView

@property (nonatomic, strong) NSArray *dataArray;

+ (CGFloat )getHeightWithDadaArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
