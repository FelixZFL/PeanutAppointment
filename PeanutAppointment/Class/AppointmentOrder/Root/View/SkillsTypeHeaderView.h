//
//  SkillsTypeHeaderView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SkillTypesModel;

NS_ASSUME_NONNULL_BEGIN

@interface SkillsTypeHeaderView : UICollectionReusableView

@property (nonatomic, strong) SkillTypesModel *typesModel;

+ (CGFloat)getHeight;

+ (NSString *) reuseIdentifier;


@end

NS_ASSUME_NONNULL_END
