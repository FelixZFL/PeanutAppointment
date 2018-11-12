//
//  BaseTableViewCell.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/19.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLine;

+ (CGFloat)getCellHeight;

+ (NSString *) reuseIdentifier;


@end
