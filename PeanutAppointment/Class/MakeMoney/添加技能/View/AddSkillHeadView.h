//
//  AddSkillHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceholderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddSkillHeadView : UIView

///技能名称
@property (nonatomic, strong) UILabel *skillNameLabel;
///1:Ta找我 2:我找Ta 3:两个都选
@property (nonatomic, assign) NSInteger serverType;
///定金
@property (nonatomic, strong) UITextField *depositTF;
///价格
@property (nonatomic, strong) UITextField *priceTF;
///计价单位（1:次/2:小时）
@property (nonatomic, assign) NSInteger PriceUnit;
///服务天数
@property (nonatomic, strong) NSArray *serverDaysArray;
///服务经历
@property (nonatomic, strong) CustomPlaceholderTextView *serverExperienceTextV;
///服务介绍
@property (nonatomic, strong) CustomPlaceholderTextView *serverIntroduceTextV;
///个人介绍
@property (nonatomic, strong) CustomPlaceholderTextView *personalIntroductionTextV;
///照片数组
@property (nonatomic, strong) NSMutableArray *photosArray;


+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
