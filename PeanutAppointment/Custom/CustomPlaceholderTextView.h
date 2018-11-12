//
//  CustomPlaceholderTextView.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 站位文字inset
 */
@property (nonatomic, assign) UIEdgeInsets placeholderInset;

@end
