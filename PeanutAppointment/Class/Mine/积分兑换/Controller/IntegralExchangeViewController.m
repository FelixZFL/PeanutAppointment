//
//  IntegralExchangeViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "IntegralExchangeViewController.h"
#import "IntegralExchangeView.h"

#import "IntegralExchangeListModel.h"

@interface IntegralExchangeViewController ()

@property (nonatomic, strong) IntegralExchangeView *headView;

@property (nonatomic, strong) IntegralExchangeListModel *chooseModel;

@end

@implementation IntegralExchangeViewController

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
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setButtonStateNormalTitle:@"兑换" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
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
    [self.customNavBar setTitle:@"积分兑换"];
}


#pragma mark - network

- (void)getData {
    [YQNetworking postWithApiNumber:API_NUM_20006 params:@{} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            NSArray *array = [IntegralExchangeListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)];
            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [IntegralExchangeView getHeightWithArray:array]);
            [self.headView setDataArr:[NSMutableArray arrayWithArray:array]];
            self.tableView.tableHeaderView = self.headView;
        }
    } failBlock:nil];
}

#pragma mark - action

- (void)submitBtnAction {
    if (self.chooseModel == nil) {
        return;
    }
    //积分兑换 暂时缺接口
    [YQNetworking postWithApiNumber:@"" params:@{} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            
        }
    } failBlock:nil];
    
}

#pragma mark - getter
- (IntegralExchangeView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[IntegralExchangeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        [_headView setChooseBlock:^(IntegralExchangeListModel * _Nonnull model) {
            weakSelf.chooseModel = model;
        }];
    }
    return _headView;
}


@end
