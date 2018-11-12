//
//  BaseBottomLineView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseBottomLineView.h"

@implementation BaseBottomLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
    }
    return self;
}

#pragma mark - getter

- (UIView *)line {
    if (!_line) {
        _line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    }
    return _line;
}

@end
