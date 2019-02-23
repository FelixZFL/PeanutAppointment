//
//  AddPhotoAlbumViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddPhotoAlbumViewController : BaseTableViewController

@property (nonatomic, copy) void(^addSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
