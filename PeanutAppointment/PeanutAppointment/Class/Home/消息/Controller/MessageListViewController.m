//
//  MessageListViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/15.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MessageListViewController.h"
#import "NavTypeChooseView.h"
#import "NotificationListCell.h"
#import "JCHATChatTable.h"
#import "AppDelegate.h"
#import "JCHATConversationListCell.h"

#import "MessageModel.h"
#import "SystemMessageModel.h"

#import "JCHATConversationViewController.h"

@interface MessageListViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,TouchTableViewDelegate,UIGestureRecognizerDelegate,JMessageDelegate,JMSGConversationDelegate>
{
    NSInteger cacheCount;
    BOOL isGetingAllConversation;
    
    __block NSMutableArray *_conversationArr;
    NSInteger _unreadCount;
}

@property (strong, nonatomic) JCHATChatTable *chatTableView;

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
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    if (!appDelegate.isDBMigrating) {
        [self addDelegate];
    } else {
        NSLog(@"is DBMigrating don't get allconversations");
        [MBProgressHUD showMessage:@"正在升级数据库" toView:self.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_type == NavTypeChooseViewType_left) {
        [self getConversationList];
    }
}

#pragma mark - UI

- (void)setupUI {
    _chatTableView = [[JCHATChatTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _chatTableView.showsVerticalScrollIndicator = NO;
    _chatTableView.delegate = self;
    _chatTableView.dataSource = self;
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatTableView.backgroundColor = COLOR_UI_F0F0F0;
    _chatTableView.hidden = NO;
    [_chatTableView registerNib:[UINib nibWithNibName:@"JCHATConversationListCell" bundle:nil] forCellReuseIdentifier:@"JCHATConversationListCell"];
    [self.view addSubview:_chatTableView];
    [_chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(NAVITETION_HEIGHT);
    }];
    
    self.tableView.hidden = YES;
    
    [self getConversationList];
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
                [self saveBadge:_unreadCount];
            } else {
                _conversationArr = nil;
            }
            [self.chatTableView reloadData];
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

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
        return @"删除";
    }
    else {
        return @"";
    }
}

//先设置Cell可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
        return YES;
    } else {
        return NO;
    }
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
        DDLogDebug(@"Action - tableView");
        JMSGConversation *conversation = [_conversationArr objectAtIndex:indexPath.row];
        
        if (conversation.conversationType == kJMSGConversationTypeSingle) {
            [JMSGConversation deleteSingleConversationWithUsername:((JMSGUser *)conversation.target).username appKey:JPushAppKey
             ];
        } else {
            [JMSGConversation deleteGroupConversationWithGroupId:((JMSGGroup *)conversation.target).gid];
        }
        
        [_conversationArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.chatTableView) {
        if ([_conversationArr count] > 0) {
            return [_conversationArr count];
        } else{
            return 0;
        }
    } else {
        return self.dataArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
        static NSString *cellIdentifier = @"JCHATConversationListCell";
        JCHATConversationListCell *cell = (JCHATConversationListCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        JMSGConversation *conversation =[_conversationArr objectAtIndex:indexPath.row];
        [cell setCellDataWithConversation:conversation];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
        return 65;
    } else {
        return [NotificationListCell getCellHeight];
    }
}

//响应点击索引时的委托方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == self.chatTableView) {
        return [_conversationArr count];
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.chatTableView) {
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
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd",badge] forKey:kBADGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 添加通知
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkConnectClose)
                                                 name:kJMSGNetworkDidCloseNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkConnectSetup)
                                                 name:kJMSGNetworkDidSetupNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectSucceed)
                                                 name:kJMSGNetworkDidLoginNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(isConnecting)
                                                 name:kJMSGNetworkIsConnectingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dBMigrateFinish)
                                                 name:kDBMigrateFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(skipToSingleChatView:)
                                                 name:kSkipToSingleChatViewState
                                               object:nil];
}

- (void)netWorkConnectClose {
    DDLogDebug(@"Action - netWorkConnectClose");
}

- (void)netWorkConnectSetup {
    DDLogDebug(@"Action - netWorkConnectSetup");
    
}

- (void)connectSucceed {
    DDLogDebug(@"Action - connectSucceed");
    
    
}

- (void)isConnecting {
    DDLogDebug(@"Action - isConnecting");
    
}

- (void)dBMigrateFinish {
    NSLog(@"Migrate is finish  and get allconversation");
    JCHATMAINTHREAD(^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
    
    [self addDelegate];
    [self getConversationList];
}

- (void)skipToSingleChatView :(NSNotification *)notification {
    JMSGUser *user = [[notification object] copy];
    __block JCHATConversationViewController *sendMessageCtl =[[JCHATConversationViewController alloc] init];//!!
    __weak typeof(self)weakSelf = self;
    sendMessageCtl.superViewController = self;
    [JMSGConversation createSingleConversationWithUsername:user.username appKey:JPushAppKey completionHandler:^(id resultObject, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error == nil) {
            sendMessageCtl.conversation = resultObject;
            JCHATMAINTHREAD(^{
                sendMessageCtl.hidesBottomBarWhenPushed = YES;
                [strongSelf.navigationController pushViewController:sendMessageCtl animated:YES];
            });
        } else {
            DDLogDebug(@"createSingleConversationWithUsername");
        }
    }];
}

- (void)addDelegate {
    [JMessage addDelegate:self withConversation:nil];
}

#pragma mark JMSGMessageDelegate
- (void)onReceiveMessage:(JMSGMessage *)message
                   error:(NSError *)error {
    DDLogDebug(@"Action -- onReceivemessage %@",message.serverMessageId);
    [self getConversationList];
}

- (void)onConversationChanged:(JMSGConversation *)conversation {
    DDLogDebug(@"Action -- onConversationChanged");
    //    [self getConversationList];
    [self onSyncReloadConversationListWithConversation:conversation];
}

- (void)onGroupInfoChanged:(JMSGGroup *)group {
    DDLogDebug(@"Action -- onGroupInfoChanged");
    [self getConversationList];
}

- (void)onSyncOfflineMessageConversation:(JMSGConversation *)conversation
                         offlineMessages:(NSArray<__kindof JMSGMessage *> *)offlineMessages {
    DDLogDebug(@"Action -- onSyncOfflineMessageConversation:offlineMessages:");
    
    //    [self getConversationList];
    [self onSyncReloadConversationListWithConversation:conversation];
}

- (void)onSyncRoamingMessageConversation:(JMSGConversation *)conversation {
    DDLogDebug(@"Action -- onSyncRoamingMessageConversation:");
    
    //    [self getConversationList];
    [self onSyncReloadConversationListWithConversation:conversation];
}

- (void)onSyncReloadConversationListWithConversation:(JMSGConversation *)conversation {
    if (!conversation) {
        return ;
    }
    BOOL isHave = NO;
    if (conversation.conversationType == kJMSGConversationTypeSingle) {
        JMSGUser *newUser = (JMSGUser *)conversation.target;
        for (int i = 0; i < _conversationArr.count; i++) {
            JMSGConversation *oldConversation = _conversationArr[i];
            if (oldConversation.conversationType == kJMSGConversationTypeSingle) {
                JMSGUser *oldUser = (JMSGUser *)oldConversation.target;
                if ([newUser.username isEqualToString:oldUser.username] && [newUser.appKey isEqualToString:oldUser.appKey]) {
                    [_conversationArr replaceObjectAtIndex:i withObject:conversation];
                    isHave = YES;
                    break ;
                }
            }
        }
    }else{
        JMSGGroup *newGroup = (JMSGGroup *)conversation.target;
        for (int i = 0; i < _conversationArr.count; i++) {
            JMSGConversation *oldConversation = _conversationArr[i];
            if (oldConversation.conversationType == kJMSGConversationTypeGroup) {
                JMSGGroup *oldGroup = (JMSGGroup *)oldConversation.target;
                if ([newGroup.gid isEqualToString:oldGroup.gid]) {
                    [_conversationArr replaceObjectAtIndex:i withObject:conversation];
                    isHave = YES;
                    break ;
                }
            }
        }
    }
    if (!isHave) {
        [_conversationArr insertObject:conversation atIndex:0];
    }
    _conversationArr = [self sortConversation:_conversationArr];
    _unreadCount = _unreadCount + [conversation.unreadCount integerValue];
    [self saveBadge:_unreadCount];
    [self.chatTableView reloadData];
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
            if (type == NavTypeChooseViewType_left) {
                weakSelf.tableView.hidden = YES;
                weakSelf.chatTableView.hidden = NO;
                [weakSelf getConversationList];
            } else {
                weakSelf.tableView.hidden = NO;
                weakSelf.chatTableView.hidden = YES;
                [weakSelf.tableView.mj_header beginRefreshing];
            }
        }];
    }
    return _navTitleView;
}

@end
