//
//  SkillCollectionCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SkillModel;

NS_ASSUME_NONNULL_BEGIN

@interface SkillCollectionCell : UICollectionViewCell

@property (nonatomic, strong) SkillModel *model;


+ (NSString *) reuseIdentifier;


@end

NS_ASSUME_NONNULL_END
