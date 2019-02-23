//
//  MaJiangHeadView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/14.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaJiangHeadView : UIView

- (void)setContentStr:(NSString *)contentStr hintStr:(NSString *)hintStr;

+ (CGFloat)getHeightWithContentStr:(NSString *)contentStr hintStr:(NSString *)hintStr;

@end

NS_ASSUME_NONNULL_END
