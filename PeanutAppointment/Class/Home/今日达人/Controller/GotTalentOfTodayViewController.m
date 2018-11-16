//
//  GotTalentOfTodayViewController.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "GotTalentOfTodayViewController.h"
#import "GotTalentOfTodayCell.h"

#import "GotTalentListModel.h"

@interface GotTalentOfTodayViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GotTalentOfTodayViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.tableView.hidden = YES;
    
    CGFloat cellWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_10)/2.f;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWidth, cellWidth);
    flowLayout.sectionInset = UIEdgeInsetsMake(MARGIN_10, MARGIN_15, MARGIN_10, MARGIN_15);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collectionView registerClass:[GotTalentOfTodayCell class] forCellWithReuseIdentifier:[GotTalentOfTodayCell reuseIdentifier]];
    
    _collectionView.backgroundColor = COLOR_UI_FFFFFF;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"今日达人"];
}

#pragma mark - refresh -

- (void)addRefresh {
    
    self.pageNum = 0;
    self.pageSize = 20;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 0;
        [self.dataArr removeAllObjects];
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageNum += 1;
        [self getData];
    }];
    
    [self getData];
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20025 params:@{@"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[GotTalentListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.collectionView reloadData];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GotTalentOfTodayCell *cell = (GotTalentOfTodayCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GotTalentOfTodayCell reuseIdentifier] forIndexPath:indexPath];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArr.count > indexPath.row) {
//        GotTalentListModel *model = self.dataArr[indexPath.row];
        [self pushTargetVCWithClassString:@"AVC_VP_VideoPlayViewController"];
    }
}


#pragma mark -- private

#pragma mark - Custom Method

- (void)pushTargetVCWithClassString:(NSString *)classString{
    Class viewControllerClass = NSClassFromString(classString);
    if (viewControllerClass) {
        UIViewController *targetVC = [[viewControllerClass alloc]init];
        if (targetVC) {
            [self.navigationController pushViewController:targetVC animated:true];
        }
    }
    
}


@end
