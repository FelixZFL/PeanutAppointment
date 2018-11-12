//
//  HomeSectionHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeChooseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) TypeChooseView *typeView;

+ (NSString *) reuseIdentifier;

+ (CGFloat)getHeight;

@end

NS_ASSUME_NONNULL_END
