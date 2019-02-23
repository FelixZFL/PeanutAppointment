//
//  RechargeAlertCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RechargeAlertListModel;

NS_ASSUME_NONNULL_BEGIN

@interface RechargeAlertCell : UICollectionViewCell

@property (nonatomic, strong) RechargeAlertListModel *model;

+ (NSString *) reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
