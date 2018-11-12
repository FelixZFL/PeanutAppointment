//
//  RechargeAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/22.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RechargeAlertView.h"
#import "RechargeAlertCell.h"

@interface RechargeAlertView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectIndex;


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
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alert {
    RechargeAlertView *alert = [[RechargeAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 385)];
    return alert;
}

#pragma mark - action -

- (void)sureClickAction:(UIButton *)sender {
    
    [YQNetworking postWithApiNumber:API_NUM_10022 params:@{@"userId":[PATool getUserId], @"money":@"",@"id":@""} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [self removFromWindow];
        }
    } failBlock:nil];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 15;//self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeAlertCell *cell = (RechargeAlertCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RechargeAlertCell reuseIdentifier] forIndexPath:indexPath];
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

@end
