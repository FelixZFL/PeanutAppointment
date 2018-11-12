//
//  Macros.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)


#define STATEBAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define NAVITETION_HEIGHT (STATEBAR_HEIGHT + 44)

#define TABBAR_HEIGHT ((IS_iPhoneX) ? 83 : 49)

#define HOMEBAR_HEIGHT ((IS_iPhoneX) ? 34 : 0)


//#define WEAK_SELF   __weak typeof(self)  __weakSelf = self;

#define kCurrentShortVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//font
#define KFont(f)  [UIFont systemFontOfSize:f]
#define KBoldFont(f)  [UIFont boldSystemFontOfSize:f]
#define KItalicFont(f)  [UIFont italicSystemFontOfSize:f]

//图片
#define imageNamed(str) [UIImage imageNamed:[NSString stringWithFormat:@"%@",str]]
///URL
#define URLWithString(str) [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]]

/*
 String
 */
#define SAFE_STR(str) ((str) == nil?@"":str)
#define SAFE_STR_ZERO(str) (((str) == nil || [str length] < 1)?@"0":str)
#define IS_STR_EMPTY(str) ((str == nil || [str length]<1 || [str isKindOfClass:[NSNull class]]) ? YES : NO )

//**** Log ****
#ifdef DEBUG

#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#   define NSLog(...)

#endif


#endif /* Macros_h */
