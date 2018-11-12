//
//  CommentToolBar.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPlaceholderTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentToolBar : UIView

@property (nonatomic, strong) CustomPlaceholderTextView *textV;

@property (nonatomic, strong) UIButton *sendBtn;

@end

NS_ASSUME_NONNULL_END
