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

@property (nonatomic, copy) NSString *choosedPusId;//选择的技能id
@property (nonatomic, copy) NSString *choosedVailDays;//有效天数
@property (nonatomic, copy) NSString *choosedPrice;//定金

@property (nonatomic, strong) HomeIndexUserModel *model;

@property (nonatomic, strong) NSArray<SkillListModel *> *skillArray;

+ (CGFloat )getHeightWithModel:(HomeIndexUserModel *)model skills:(NSArray *)skillArray;

@end

