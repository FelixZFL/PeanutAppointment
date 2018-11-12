//
//  MyAccountCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TitleImageButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyAccountCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) TitleImageButton *nextBtn;

@end

NS_ASSUME_NONNULL_END
