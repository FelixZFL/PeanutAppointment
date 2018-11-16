//
//  ReleaseOrderViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ReleaseOrderViewController.h"
#import "ReleaseOrderHeadView.h"
#import "ReleaseOrderFootView.h"
#import "LocationManager.h"
#import "ReleaseOrderUserModel.h"


@interface ReleaseOrderViewController ()

@property (nonatomic, strong) CLLocation *location;//当前定位

@property (nonatomic, strong) ReleaseOrderHeadView *headView;
@property (nonatomic, strong) ReleaseOrderFootView *footView;
@property (nonatomic, strong) UIButton *releaseBtn;

@property (nonatomic, strong) NSMutableArray *likeArray;

@end

@implementation ReleaseOrderViewController

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
    
    self.pageNum = 0;
    self.pageSize = 20;
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableHeaderView = self.headView;
    
    UIButton *releaseBtn = [[UIButton alloc] init];
    [releaseBtn setButtonStateNormalTitle:@"发布需求" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    releaseBtn.backgroundColor = COLOR_UI_THEME_RED;
    [releaseBtn addTarget:self action:@selector(releaseBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:releaseBtn];
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    self.releaseBtn = releaseBtn;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
    self.tableView.hidden = self.releaseBtn.hidden = YES;
}

- (void)setupNav {
    [self.customNavBar setTitle:@"发布需求"];
}

- (void)updateFootView {
    if (self.likeArray.count > 0) {
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [ReleaseOrderFootView getHeightWithArray:self.likeArray]);
        [self.footView setArray:self.likeArray];
        self.tableView.tableFooterView = self.footView;
    } else {
        self.tableView.tableFooterView = nil;
    }
}

#pragma mark - network

- (void)getData {
    if (_location) {
        NSString *jnId = _pasId ?:@"";
        [YQNetworking postWithApiNumber:API_NUM_20014 params:@{@"jnId":jnId,@"lng":@(_location.coordinate.longitude),@"lat":@(_location.coordinate.latitude), @"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
            
            if (getResponseIsSuccess(response)) {
                [self.dataArr addObjectsFromArray:[ReleaseOrderUserModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
                if (self.dataArr.count > 0) {
                    [self.headView setModel:self.dataArr.firstObject];
                }
            }
            self.tableView.hidden = self.releaseBtn.hidden = self.dataArr.count < 1;            
        } failBlock:^(NSError *error) {
        }];
    } else {
        [[LocationManager sharedManager].locationManager requestLocationWithReGeocode:NO withNetworkState:NO completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
            if (!error) {
                self.location = location.location;
                [self getData];
            }
        }];
    }
}


#pragma mark - action

- (void)releaseBtnClickAction:(UIButton *)sender {
    
}

#pragma mark - private -

#pragma mark - getter

- (ReleaseOrderHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[ReleaseOrderHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ReleaseOrderHeadView getHeight])];
        [_headView setChooseBlock:^(BOOL isLike, ReleaseOrderUserModel * _Nonnull model) {
            if (isLike) {
                [weakSelf.likeArray addObject:model];
                [weakSelf updateFootView];
            }
            [weakSelf.dataArr removeObject:model];
            if (weakSelf.dataArr.count > 0) {
                [weakSelf.headView setModel:weakSelf.dataArr.firstObject];
            } else {
                weakSelf.pageNum += 1;
                [weakSelf getData];
            }
        }];
    }
    return _headView;
}

- (ReleaseOrderFootView *)footView {
    if (!_footView) {
        __weak __typeof(self)weakSelf = self;
        _footView = [[ReleaseOrderFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [ReleaseOrderFootView getHeightWithArray:@[]])];
        [_footView setBtnClickBlcok:^(NSInteger index) {
            [weakSelf.likeArray removeObjectAtIndex:index];
            [weakSelf updateFootView];
        }];
    }
    return _footView;
}

- (NSMutableArray *)likeArray {
    if (!_likeArray) {
        _likeArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _likeArray;
}

@end
