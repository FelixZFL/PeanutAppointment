//
//  RebateRankingCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class RebateRankingModel;

NS_ASSUME_NONNULL_BEGIN

@interface RebateRankingCell : BaseTableViewCell

- (void)setModel:(RebateRankingModel * _Nonnull)model index:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
