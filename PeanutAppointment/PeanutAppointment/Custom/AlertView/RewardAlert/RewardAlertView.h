//
//  RewardAlertView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

///类型（1：个人中心首页图片/2：技能打赏/3：短视频/4：直播）
typedef enum : NSUInteger {
    ///个人中心首页图片
    RewardAlertType_UserPagePhoto = 1,
    ///技能打赏
    RewardAlertType_Skill = 2,
    ///短视频
    RewardAlertType_Video = 3,
    ///直播
    RewardAlertType_Alive = 4,
} RewardAlertType;

NS_ASSUME_NONNULL_BEGIN

@interface RewardAlertView : UIView

- (void)showInWindow;

- (void)removFromWindow;

//ID（技能id或者视频id或者直播id） 
//+ (instancetype )alertWithID:(NSString *)ID type:(RewardAlertType )type;
+ (instancetype )alertWithUserId:(NSString *)userId thingsID:(NSString *)ID type:(RewardAlertType )type;
@end

NS_ASSUME_NONNULL_END
