//
//  RewardModel.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/7.
//  Copyright © 2018 felix. All rights reserved.
//

#import "RewardModel.h"

@implementation RewardModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"giftList":[RewardGiftListModel class],@"ranking":[RewardRankingModel class]};
}

@end


@implementation RewardGiftListModel
@end

@implementation RewardRankingModel
@end
