//
//  OrderManageManageCell.h
//  PeanutAppointment
//
//  Created by felix on 2018/9/30.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class OrderManageListModel;
@class OrderManageInvitedListModel;

@interface OrderManageManageCell : BaseTableViewCell

@property (nonatomic, copy) void(^clickHeadBlock)(OrderManageListModel *model, OrderManageInvitedListModel *invitedModel);

@property (nonatomic, strong) OrderManageListModel *model;

+ (CGFloat)getCellHeightWithModel:(OrderManageListModel *)model;


@end


#pragma mark - ============= OrderManageManageHeadCell ===============

@interface OrderManageManageHeadCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *headImageV;

@property (strong, nonatomic) UIView *redDotView;


+ (NSString *) reuseIdentifier;

@end

