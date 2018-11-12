//
//  MyMainPageHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyMainPageModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyMainPageHeadView : UIView

+ (CGFloat )getHeightWithModel:(MyMainPageModel *)model;

- (void)updateWithModel:(MyMainPageModel *)model;

@end

NS_ASSUME_NONNULL_END



#pragma mark - ============= OrderManageManageHeadCell ===============

@interface VisitorHeadCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *headImageV;

+ (NSString *) reuseIdentifier;

@end
