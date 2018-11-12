//
//  GotTalentOfTodayCell.h
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GotTalentListModel;

NS_ASSUME_NONNULL_BEGIN

@interface GotTalentOfTodayCell : UICollectionViewCell

@property (nonatomic, strong) GotTalentListModel *model;

+ (NSString *) reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
