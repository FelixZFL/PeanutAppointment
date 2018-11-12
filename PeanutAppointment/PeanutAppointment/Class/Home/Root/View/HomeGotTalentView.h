//
//  HomeGotTalentView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNoticeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeGotTalentView : UIView

@property (nonatomic, strong) HomeNoticeView *noticeView;

@property (nonatomic, strong) NSMutableArray *photoViewArray;

+ (CGFloat )getHeight;

@end

NS_ASSUME_NONNULL_END
