//
//  BaseTextField.m
//  ainonggu
//
//  Created by zfl－mac on 2018/8/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textColor = COLOR_UI_222222;
        self.font = KFont(14);
        
        [self setDefaultCorner];
        [self setborderColor:COLOR_UI_999999];
        
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
