//
//  AutoReplyEditViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AutoReplyEditViewController.h"
#import "CustomPlaceholderTextView.h"

@interface AutoReplyEditViewController ()

@property (nonatomic, strong) CustomPlaceholderTextView *replyTextV;

@end

@implementation AutoReplyEditViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

#pragma mark - UI

- (void)setupUI {
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedAction:)]];
    
    CGFloat textVHeight = 250;
    
    UIView *headView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, textVHeight + MARGIN_10 * 2);
    CustomPlaceholderTextView *replyTextV = [[CustomPlaceholderTextView alloc] initWithFrame:CGRectMake(MARGIN_15, MARGIN_10, SCREEN_WIDTH - MARGIN_15 * 2, textVHeight)];
    replyTextV.textColor = COLOR_UI_222222;
    [replyTextV setborderColor:COLOR_UI_999999];
    [replyTextV setDefaultCorner];
    [headView addSubview:replyTextV];
    replyTextV.placeholder = @"请输入回复内容";
    replyTextV.text = @"我对您的订单很感兴趣，期待您的回复，如果我不在线，请留言，我将第一时间回复您。";
    self.replyTextV = replyTextV;
    self.tableView.tableHeaderView = headView;
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setButtonStateNormalTitle:@"提交回复" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    submitBtn.backgroundColor = COLOR_UI_THEME_RED;
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"编辑回复"];
}


#pragma mark - network


#pragma mark - action

- (void)submitBtnAction {
    
}

#pragma mark - private -
- (void)tapGesturedAction:(UIGestureRecognizer *)gesture {
    
    [self.view endEditing:YES];
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - getter


@end
