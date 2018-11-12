//
//  CardAuthHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardAuthHeadView : UIView

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *cardTF;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
