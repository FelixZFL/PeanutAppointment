//
//  MessageListViewController.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListViewController : BaseTableViewController
{
    NSInteger cacheCount;
    BOOL isGetingAllConversation;
    
    __block NSMutableArray *_conversationArr;
    NSInteger _unreadCount;
}

@end

NS_ASSUME_NONNULL_END
