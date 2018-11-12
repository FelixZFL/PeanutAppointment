//
//  HomeTitleView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTitleView : UIView

- (void)setChiniseTitle:(NSString *)cTitle englishTitle:(NSString *)eTitle;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
