//
//  RewardAlertCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class RewardRankingModel;

NS_ASSUME_NONNULL_BEGIN

@interface RewardAlertCell : BaseTableViewCell

- (void)setModel:(RewardRankingModel * _Nonnull)model index:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
