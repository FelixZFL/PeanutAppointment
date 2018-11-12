//
//  OrderManageManageCell.h
//  PeanutAppointment
//
//  Created by felix on 2018/9/30.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrderManageManageCell : BaseTableViewCell

@end


#pragma mark - ============= OrderManageManageHeadCell ===============

@interface OrderManageManageHeadCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *headImageV;

@property (strong, nonatomic) UIView *redDotView;


+ (NSString *) reuseIdentifier;

@end

