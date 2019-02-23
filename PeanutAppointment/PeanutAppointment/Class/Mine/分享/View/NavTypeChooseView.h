//
//  NavTypeChooseView.h
//  shopping
//
//  Created by XB on 2018/5/23.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NavTypeChooseViewWidth 210
#define NavTypeChooseViewHeight 44

typedef enum : NSUInteger {
    NavTypeChooseViewType_left,
    NavTypeChooseViewType_right,
} NavTypeChooseViewType;


@interface NavTypeChooseView : UIView

@property (nonatomic, assign) NavTypeChooseViewType type;

@property (nonatomic, copy) void(^navTypeChooseBlock) (NavTypeChooseViewType type);

- (void)setleftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle;

@end
