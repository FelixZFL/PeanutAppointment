//
//  MaJiangViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/14.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

typedef enum : NSUInteger {
    MaJiangVCType_Main,//主页
    MaJiangVCType_Vip,//vip
    MaJiangVCType_RoomCard,//房卡
} MaJiangVCType;


NS_ASSUME_NONNULL_BEGIN

@interface MaJiangViewController : BaseTableViewController

@property (nonatomic, assign) MaJiangVCType type;

@end

NS_ASSUME_NONNULL_END
