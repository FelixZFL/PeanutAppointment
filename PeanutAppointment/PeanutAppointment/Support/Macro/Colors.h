//
//  Colors.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#ifndef Colors_h
#define Colors_h


#import "UIColor+FLExtension.h"

#define KColor(color)  [UIColor color]
#define KHexColor(color) [UIColor fl_colorWithHexString:color]

#define COLOR_UI_RANDOM [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.8]

#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]


#define COLOR_UI_FFFFFF [UIColor fl_colorWithHexString:@"FFFFFF"]  //白色
#define COLOR_UI_000000 [UIColor fl_colorWithHexString:@"000000"]  //黑色


#define COLOR_UI_F0F0F0 [UIColor fl_colorWithHexString:@"F0F0F0"]  //列表底色  灰
//
#define COLOR_UI_222222 [UIColor fl_colorWithHexString:@"222222"]  //正文文字颜色 黑
#define COLOR_UI_666666 [UIColor fl_colorWithHexString:@"666666"]  //次要文字颜色 灰  底部tabbar 未选中标题色
#define COLOR_UI_999999 [UIColor fl_colorWithHexString:@"999999"]  //次要文字颜色 浅灰  输入框站位文字颜色


#define COLOR_UI_THEME_RED [UIColor fl_colorWithHexString:@"F6308D"]  //主题 红


#endif /* Colors_h */
