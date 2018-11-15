//
//  AppointmentHerHeadView.h
//  PeanutAppointment
//
//  Created by felix on 2018/10/25.
//  Copyright © 2018 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeIndexUserModel;
@class SkillListModel;

@interface AppointmentHerHeadView : UIView

@property (nonatomic, strong) HomeIndexUserModel *model;

@property (nonatomic, strong) NSArray<SkillListModel *> *skillArray;

+ (CGFloat )getHeightWithModel:(HomeIndexUserModel *)model skills:(NSArray *)skillArray;

@end

