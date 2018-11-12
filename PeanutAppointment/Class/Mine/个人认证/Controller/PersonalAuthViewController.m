//
//  PersonalAuthViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PersonalAuthViewController.h"
#import "PersonalAuthCell.h"

#import "PersonalAuthModel.h"

@interface PersonalAuthViewController ()

@property (nonatomic, strong) PersonalAuthModel *model;

@end

@implementation PersonalAuthViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)setupUI {
    NSArray *array = @[@{@"icon":@"personalAuth_icon_phone",@"text":@"手机认证"},
                       @{@"icon":@"personalAuth_icon_skill",@"text":@"技能认证"},
                       @{@"icon":@"personalAuth_icon_weichat",@"text":@"微信认证"},
                       @{@"icon":@"personalAuth_icon_idCard",@"text":@"身份证认证"},
                       @{@"icon":@"personalAuth_icon_alipay",@"text":@"支付宝认证"}
                       ];
    self.dataArr = [NSMutableArray arrayWithArray:array];
}

- (void)setupNav {
    [self.customNavBar setTitle:@"个人认证"];
}


#pragma mark - network

- (void)getData {
    [YQNetworking postWithApiNumber:API_NUM_20011 params:@{@"userId":[PATool getUserId],@"page":@(0),@"limit":@(10)} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            self.model = [PersonalAuthModel mj_objectWithKeyValues:getResponseData(response)];
            [self.tableView reloadData];
        }
    } failBlock:nil];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PersonalAuthCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [PersonalAuthCell reuseIdentifier];
    PersonalAuthCell *cell = (PersonalAuthCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PersonalAuthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.imageV.image = imageNamed(dic[@"icon"]);
    cell.contentLabel.text = dic[@"text"];
    if (self.model) {
        if (indexPath.row == 0) {
            cell.statusLabel.text = self.model.phone.length > 0 ? @"已认证" : @"未认证";
        } else if (indexPath.row == 1) {
            cell.statusLabel.text = [self.model.isCertification integerValue]== 1 ? @"已认证" : @"未认证";
        } else if (indexPath.row == 2) {
            cell.statusLabel.text = self.model.wxNumber.length > 0 ? @"已认证" : @"未认证";
        } else if (indexPath.row == 3) {
            NSString *status = @"";
            if ([self.model.idCard integerValue] == 0) {
                status = @"未认证";
            } else if ([self.model.idCard integerValue] == 1) {
                status = @"已认证";
            } else if ([self.model.idCard integerValue] == 2) {
                status = @"待审核";
            } else if ([self.model.idCard integerValue] == 3) {
                status = @"审核失败";
            }
            cell.statusLabel.text = status;
        } else if (indexPath.row == 4) {
            cell.statusLabel.text = self.model.aliPayNumber.length > 0 ? @"已认证" : @"未认证";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter



@end
