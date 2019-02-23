//
//  MyExceptionalCell.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MyExceptionalListModel;

NS_ASSUME_NONNULL_BEGIN

@interface MyExceptionalCell : BaseTableViewCell

- (void)setModel:(MyExceptionalListModel * _Nonnull)model index:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
