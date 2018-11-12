//
//  CommodityCountChangeView.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CommodityCountChangeViewHeight 26

typedef enum : NSUInteger {
    CountChangeType_Add,
    CountChangeType_Minus,
} CountChangeType;

@interface CommodityCountChangeView : UIView

@property (nonatomic, copy) void(^chooseNumChangedBlock) (NSInteger currentNun, CountChangeType type);

@property (nonatomic, assign) NSInteger maxNum;

@property (nonatomic, assign) NSInteger currentNum;


@end
