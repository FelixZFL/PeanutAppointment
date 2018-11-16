//
//  DemandDetailCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class DemanDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface DemandDetailCell : BaseTableViewCell

@property (nonatomic, copy) void(^btnClickBlock) (DemanDetailModel *model, UIButton *sender);

@property (nonatomic, strong) DemanDetailModel *model;

+ (CGFloat)getCellHeightWithModel:(DemanDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
