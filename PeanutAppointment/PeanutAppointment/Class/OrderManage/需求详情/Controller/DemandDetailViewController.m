//
//  DemandDetailViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "DemandDetailViewController.h"
#import "DemandDetailHeadView.h"
#import "DemandDetailCell.h"

#import "DemanDetailModel.h"

#import "JCHATConversationViewController.h"//聊天


@interface DemandDetailViewController ()

@property (nonatomic, strong) DemandDetailHeadView *headView;

@property (nonatomic, strong) DemanDetailModel *model;

@end

@implementation DemandDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI -

- (void)setupNav {
    
    [self setTitle:@"需求详情"];
    
}

- (void)setupUI {
    
}

- (void)updateUI {
    if (self.model) {
        [self.headView setModel:self.model];
        self.tableView.tableHeaderView = self.headView;
        [self.tableView reloadData];
    }
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20029 params:@{@"orderId":_orderId, @"yUserId":_yUserId} successBlock:^(id response) {

        if (getResponseIsSuccess(response)) {
            
            self.model = [DemanDetailModel mj_objectWithKeyValues:getResponseData(response)];
            self.model.state = self.state;
            [self updateUI];
        }

    } failBlock:^(NSError *error) {
    }];
}

#pragma mark - action


#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model) {
        return [DemandDetailCell getCellHeightWithModel:self.model];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [DemandDetailCell reuseIdentifier];
    DemandDetailCell *cell = (DemandDetailCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DemandDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBtnClickBlock:^(DemanDetailModel * _Nonnull model, UIButton * _Nonnull sender) {
            
            if ([sender.titleLabel.text isEqualToString:@"发消息"]) {
                [JMSGConversation createSingleConversationWithUsername:self.yUserId completionHandler:^(id resultObject, NSError *error) {
                    if (!error) {
                        //创建单聊会话成功， resultObject为创建的会话
                        
                        JCHATConversationViewController *sendMessageCtl =[[JCHATConversationViewController alloc] init];
                        sendMessageCtl.hidesBottomBarWhenPushed = YES;
                        sendMessageCtl.superViewController = self;
                        JMSGConversation *conversation = (JMSGConversation *)resultObject;
                        sendMessageCtl.conversation = conversation;
                        [self.navigationController pushViewController:sendMessageCtl animated:YES];
                    } else {
                        //创建单聊会话失败
                    }
                }];
                
            } else if ([sender.titleLabel.text isEqualToString:@"确认支付"]) {
                
                [YQNetworking postWithApiNumber:API_NUM_10020 params:@{@"orderId":self.orderId, @"yUserId":self.yUserId} successBlock:^(id response) {
                    
                    if (getResponseIsSuccess(response)) {
                        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                } failBlock:nil];
                
            } else if ([sender.titleLabel.text isEqualToString:@"申请退款"]) {
                
            } else if ([sender.titleLabel.text isEqualToString:@"付余款"]) {
                
            } else if ([sender.titleLabel.text isEqualToString:@"去评价"]) {
                
            }
        }];
    }
    if (self.model) {
        [cell setModel:self.model];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter

- (DemandDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[DemandDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [DemandDetailHeadView getHeight])];
    }
    return _headView;
}

@end
