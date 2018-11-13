//
//  BuyVIPViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "BuyVIPViewController.h"
#import "BuyVIPHeadView.h"
#import "BuyVIPModel.h"

@interface BuyVIPViewController ()

@property (nonatomic, strong) BuyVIPHeadView *headView;

@property (nonatomic, strong) BuyVIPModel *selectModel;

@end

@implementation BuyVIPViewController

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
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableHeaderView = self.headView;
    
    
    UIButton *buyBtn = [[UIButton alloc] init];
    [buyBtn setButtonStateNormalTitle:@"开通" Font:KFont(17) textColor:COLOR_UI_FFFFFF];
    buyBtn.backgroundColor = COLOR_UI_THEME_RED;
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_42);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_42);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"购买会员"];
    [self setNavStyle:CustomNavStyle_Default];
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20003 params:@{} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            NSArray *array = [BuyVIPModel mj_objectArrayWithKeyValuesArray:getResponseData(response)];
            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [BuyVIPHeadView getHeightWithArray:array]);
            [self.headView updateWithArray:array];
            self.tableView.tableHeaderView = self.headView;
        }
        
    } failBlock:^(NSError *error) {
    }];
}


#pragma mark - action

- (void)buyBtnAction {
    NSLog(@"购买vip");
    if (self.selectModel) {
        [YQNetworking postWithApiNumber:API_NUM_10014 params:@{@"userId":[PATool getUserId],@"piwId":self.selectModel.pvbId} successBlock:^(id response) {
            if (getResponseIsSuccess(response)) {
                [self getData];
                [[AlertBaseView alertWithTitle:@"开通会员成功" leftBtn:nil leftBlock:nil rightBtn:@"确定" rightBlock:nil] showInWindow];
            }
        } failBlock:nil];
    }
}

#pragma mark - getter

- (BuyVIPHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[BuyVIPHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [BuyVIPHeadView getHeightWithArray:@[]])];
        [_headView setChooseBlock:^(BuyVIPModel * _Nonnull model) {
            weakSelf.selectModel = model;
        }];
    }
    return _headView;
}

@end
