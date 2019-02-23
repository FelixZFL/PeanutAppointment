//
//  MyInfoCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class UserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoCell : BaseTableViewCell

@property (nonatomic, strong) UITextField *nickNameTF;

- (void)updateWithModel:(UserInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
