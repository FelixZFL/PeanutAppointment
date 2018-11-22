//
//  MessageListViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MessageListViewController.h"
#import "NavTypeChooseView.h"
#import "MessageListCell.h"
#import "NotificationListCell.h"

#import "MessageModel.h"
#import "SystemMessageModel.h"

#import "JCHATConversationViewController.h"

@interface MessageListViewController ()

@property (nonatomic, strong) NavTypeChooseView *navTitleView;
@property (nonatomic, assign) NavTypeChooseViewType type;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
}

- (void)setupNav {
    
    [self.customNavBar setTitleView:self.navTitleView];
    [self.view bringSubviewToFront:self.customNavBar];
    
}

#pragma mark - refresh -

- (void)addRefresh {

    self.pageNum = 0;
    self.pageSize = 10;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 0;
        [self.dataArr removeAllObjects];
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageNum += 1;
        [self getData];
    }];

    [self getData];
}


#pragma mark - network

- (void)getData {
    [SVProgressHUD showWithClearMaskType];
    // type：类型（1:系统消息/2:消息）
    [YQNetworking postWithApiNumber:API_NUM_20024 params:@{@"type":_type == NavTypeChooseViewType_left ? @"2" : @"1", @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        [SVProgressHUD dismissToMaskTypeNone];
        if (getResponseIsSuccess(response)) {
            if (self.type == NavTypeChooseViewType_left) {
                [self.dataArr addObjectsFromArray:[MessageModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            } else {
                [self.dataArr addObjectsFromArray:[SystemMessageModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [SVProgressHUD dismissToMaskTypeNone];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)getConversationList {
    
    if (isGetingAllConversation) {
        NSLog(@"is loading conversation list");
        cacheCount++;
        return ;
    }
    
    NSLog(@"get allConversation -- start");
    isGetingAllConversation = YES;
    
//    [self.addBgView setHidden:YES];
    [JMSGConversation allConversations:^(id resultObject, NSError *error) {
        JCHATMAINTHREAD(^{
            isGetingAllConversation = NO;
            if (error == nil) {
                _conversationArr = [self sortConversation:resultObject];
                _unreadCount = 0;
                for (NSInteger i=0; i < [_conversationArr count]; i++) {
                    JMSGConversation *conversation = [_conversationArr objectAtIndex:i];
                    _unreadCount = _unreadCount + [conversation.unreadCount integerValue];
                }
//                [self saveBadge:_unreadCount];
            } else {
                _conversationArr = nil;
            }
//            [self.chatTableView reloadData];
            NSLog(@"get allConversation -- end");
            isGetingAllConversation = NO;
            [self checkCacheGetAllConversationAction];
        });
    }];
}

- (void)checkCacheGetAllConversationAction {
    if (cacheCount > 0) {
        NSLog(@"is have cache ,once again get all conversation");
        cacheCount = 0;
        [self getConversationList];
    }
}


#pragma mark --排序conversation
- (NSMutableArray *)sortConversation:(NSMutableArray *)conversationArr {
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"latestMessage.timestamp" ascending:NO];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    
    NSArray *sortedArray = [conversationArr sortedArrayUsingDescriptors:sortDescriptors];
    
    return [NSMutableArray arrayWithArray:sortedArray];
    
    //    NSArray *sortResultArr = [conversationArr sortedArrayUsingFunction:sortType context:nil];
    //    return [NSMutableArray arrayWithArray:sortResultArr];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == NavTypeChooseViewType_left) {
        return [MessageListCell getCellHeight];
    } else {
        return [NotificationListCell getCellHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == NavTypeChooseViewType_left) {
        NSString *identifier = [MessageListCell reuseIdentifier];
        MessageListCell *cell = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MessageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (self.dataArr.count > indexPath.row) {
            [cell setModel:self.dataArr[indexPath.row]];
        }
        return cell;
        
    } else {
        NSString *identifier = [NotificationListCell reuseIdentifier];
        NotificationListCell *cell = (NotificationListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NotificationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (self.dataArr.count > indexPath.row) {
            [cell setModel:self.dataArr[indexPath.row]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type == NavTypeChooseViewType_left) {
        
        JCHATConversationViewController *sendMessageCtl =[[JCHATConversationViewController alloc] init];
        sendMessageCtl.hidesBottomBarWhenPushed = YES;
        sendMessageCtl.superViewController = self;
        JMSGConversation *conversation = [_conversationArr objectAtIndex:indexPath.row];
        sendMessageCtl.conversation = conversation;
        [self.navigationController pushViewController:sendMessageCtl animated:YES];
        
        NSInteger badge = _unreadCount - [conversation.unreadCount integerValue];
        [self saveBadge:badge];
    }
    
}

- (void)saveBadge:(NSInteger)badge {
//    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd",badge] forKey:kBADGE];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - getter

- (NavTypeChooseView *)navTitleView {
    if (!_navTitleView) {
        _navTitleView = [[NavTypeChooseView alloc] initWithFrame:CGRectMake(0, 0, NavTypeChooseViewWidth, NavTypeChooseViewHeight)];
        [_navTitleView setleftBtnTitle:@"消息" rightBtnTitle:@"通知"];
        self.type = NavTypeChooseViewType_left;
        [_navTitleView setType:NavTypeChooseViewType_left];
        __weak __typeof(self)weakSelf = self;
        [_navTitleView setNavTypeChooseBlock:^(NavTypeChooseViewType type) {
            NSLog(@"type---%lu",(unsigned long)type);
            weakSelf.type = type;
            [weakSelf.tableView.mj_header beginRefreshing];
        }];
    }
    return _navTitleView;
}

@end
