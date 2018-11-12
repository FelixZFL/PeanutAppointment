//
//  FeedbackViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackHeadView.h"
#import "AddPhotoAlbumFootView.h"

@interface FeedbackViewController ()

@property (nonatomic, strong) FeedbackHeadView *headView;
@property (nonatomic, strong) AddPhotoAlbumFootView *footView;

@end

@implementation FeedbackViewController

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
    
    self.tableView.tableHeaderView = self.headView;
    if (self.type == FeedbackViewType_feedback) {
        self.headView.feedBackTextView.placeholder = @"请尽可能的详细描述您遇到的问题，了手机发了了撒看附件了撒地方就撒萨拉附件撒撒两节课撒撒附件字以内";
    } else {
        self.headView.feedBackTextView.placeholder = @"请尽可能的详细描述您遇到的问题，了手机发了了撒看附件了撒地方就撒萨拉附件撒撒两节课撒撒附件150字以内";
    }
    
    self.tableView.tableFooterView = self.footView;
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setButtonStateNormalTitle:@"提交" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
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
    if (self.type == FeedbackViewType_feedback) {
        [self.customNavBar setTitle:@"建议与反馈"];
    } else {
        [self.customNavBar setTitle:@"举报"];
    }
}


#pragma mark - network


#pragma mark - action

- (void)submitBtnAction {
    
    if (self.headView.feedBackTextView.text.length < 1) {
        if (self.type == FeedbackViewType_feedback) {
            [SVProgressHUD showErrorWithStatus:@"请输入建议与反馈内容"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请输入举报内容"];
        }
        return;
    }
    
    //图片url 多张图片逗号分隔
    NSString *picUrl = @"";
    
    [YQNetworking postWithApiNumber:API_NUM_10006 params:@{@"userId":[PATool getUserId],@"content":self.headView.feedBackTextView.text,@"photoUrl":picUrl} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failBlock:nil];
    
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

- (FeedbackHeadView *)headView {
    if (!_headView) {
        _headView = [[FeedbackHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [FeedbackHeadView getHeight])];
    }
    return _headView;
}

- (AddPhotoAlbumFootView *)footView {
    if (!_footView) {
        _footView = [[AddPhotoAlbumFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AddPhotoAlbumFootView getHeight])];
        _footView.titleLabel.text = @"问题描述";
        _footView.contentLabel.hidden = YES;
    }
    return _footView;
}

@end
