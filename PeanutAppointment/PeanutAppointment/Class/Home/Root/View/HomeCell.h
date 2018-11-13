//
//  HomeCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class HomeIndexUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : BaseTableViewCell

@property (nonatomic, copy) void(^userInfoBlock) (HomeIndexUserModel *model);
@property (nonatomic, copy) void(^imageClickBlock) (NSInteger index, HomeIndexUserModel *model);
@property (nonatomic, copy) void(^btnClickBlock)(NSInteger index, HomeIndexUserModel *model, UIButton *btn);

@property (nonatomic, strong) HomeIndexUserModel *model;

@end

NS_ASSUME_NONNULL_END
