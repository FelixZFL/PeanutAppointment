//
//  RechargeAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RechargeAlertView.h"
#import "RechargeAlertCell.h"

#import "RechargeAlertListModel.h"
#import "RechargeViewController.h"

@interface RechargeAlertView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RechargeAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndex = 0;
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    UILabel *titleLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentCenter];
    titleLabel.text = @"充值";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    UIView *topLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setButtonStateNormalTitle:@"确定" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    sureBtn.backgroundColor = COLOR_UI_THEME_RED;
    [sureBtn addTarget:self action:@selector(sureClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(topLine.mas_bottom);
        make.bottom.equalTo(sureBtn.mas_top);
    }];
    
    //rechargeAlert_diamond
    
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.2);
    [self.layerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removFromWindow)]];
    [window addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [window addSubview:self];
    self.y = window.height - 385;
    [self getData];
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alert {
    RechargeAlertView *alert = [[RechargeAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 385)];
    return alert;
}


#pragma mark - network -

- (void)getData{
    [YQNetworking postWithApiNumber:API_NUM_20039 params:@{} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            self.dataArray = [RechargeAlertListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)];
            self.selectIndex = 0;
            [self.collectionView reloadData];
        } else {
            [self removFromWindow];
        }
    } failBlock:^(NSError *error) {
        [self removFromWindow];
    }];
}


#pragma mark - action -

- (void)sureClickAction:(UIButton *)sender {
    
    if (self.dataArray.count > _selectIndex) {
        RechargeAlertListModel *model = self.dataArray[_selectIndex];
        [YQNetworking postWithApiNumber:API_NUM_10022 params:@{@"userId":[PATool getUserId], @"money":model.rmb,@"id":model.ID} successBlock:^(id response) {
            if (getResponseIsSuccess(response)) {
                NSDictionary *dic = getResponseData(response);
                if ([dic[@"isSuccess"] integerValue] == 1 || [dic[@"success"] integerValue] == 1) {
                    [[AlertBaseView alertWithTitle:@"充值成功" leftBtn:nil leftBlock:nil rightBtn:@"确定" rightBlock:^{
                        [self removFromWindow];
                    }] showInWindow];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"余额不足"];
                    UIViewController *currentVC = [UIViewController fl_currentViewController];
                    RechargeViewController *vc = [[RechargeViewController alloc] init];
                    [currentVC.navigationController pushViewController:vc animated:YES];
                    [self removFromWindow];
                }
            }
        } failBlock:nil];
    }
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeAlertCell *cell = (RechargeAlertCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RechargeAlertCell reuseIdentifier] forIndexPath:indexPath];
    }
    if (self.dataArray.count > indexPath.row) {
        [cell setModel:self.dataArray[indexPath.row]];
    }
    [cell setborderColor:COLOR_UI_THEME_RED borderWidth:_selectIndex == indexPath.row ? 1 : 0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath.row;
    [self.collectionView reloadData];
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
                
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(75, 95);
        flowLayout.sectionInset = UIEdgeInsetsMake(MARGIN_10, MARGIN_15, MARGIN_10, MARGIN_15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_collectionView registerClass:[RechargeAlertCell class] forCellWithReuseIdentifier:[RechargeAlertCell reuseIdentifier]];
        
        _collectionView.backgroundColor = COLOR_UI_FFFFFF;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
