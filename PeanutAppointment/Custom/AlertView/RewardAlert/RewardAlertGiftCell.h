//
//  RewardAlertGiftCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RewardGiftListModel;

NS_ASSUME_NONNULL_BEGIN

@interface RewardAlertGiftCell : UICollectionViewCell

@property (nonatomic, strong) RewardGiftListModel *model;

+ (NSString *) reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
