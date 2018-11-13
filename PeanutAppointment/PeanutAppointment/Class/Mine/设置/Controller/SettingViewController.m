//
//  SettingViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"

#import "ChangePasswordViewController.h"
#import "FeedbackViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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


#pragma mark - UI

- (void)setupUI {
    
    UIButton *logoutBtn = [[UIButton alloc] init];
    [logoutBtn setButtonStateNormalTitle:@"退出登录" Font:KFont(17) textColor:COLOR_UI_666666];
    logoutBtn.backgroundColor = COLOR_UI_FFFFFF;
    [logoutBtn addTarget:self action:@selector(logoutBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.customNavBar setTitle:@"设置"];
}


#pragma mark - action

- (void)logoutBtnAction {
    [[AlertBaseView alertWithTitle:@"您确定要退出登录" leftBtn:@"取消" leftBlock:nil rightBtn:@"确定" rightBlock:^{
        //TODO  退出
    }] showInWindow];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SettingCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [SettingCell reuseIdentifier];
    SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改密码";
    } else {
        cell.textLabel.text = @"建议与反馈";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        //修改密码
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        //建议与反馈
        FeedbackViewController *vc = [[FeedbackViewController alloc] init];
        vc.type = FeedbackViewType_feedback;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - getter


@end
