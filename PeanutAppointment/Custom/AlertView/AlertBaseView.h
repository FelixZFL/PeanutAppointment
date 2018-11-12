//
//  AlertBaseView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AlertItemClickBlock)(void);

@interface AlertBaseView : UIView

- (void)showInWindow;

- (void)removFromWindow;

+ (instancetype ) alertWithTitle:(NSString *)title leftBtn:(NSString *)leftBtn leftBlock:(AlertItemClickBlock)leftBlock rightBtn:(NSString *)rightBtn rightBlock:(AlertItemClickBlock)rightBlock;

@end

