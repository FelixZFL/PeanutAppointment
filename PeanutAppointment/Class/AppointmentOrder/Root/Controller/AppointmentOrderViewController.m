//
//  AppointmentOrderViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/9.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AppointmentOrderViewController.h"
#import "PACollectionFlowLayout.h"
#import "SkillsTypeHeaderView.h"
#import "SkillCollectionCell.h"

#import "SkillTypesModel.h"

#import "ReleaseOrderViewController.h"//发布
#import "SearchViewController.h"//搜索
#import "MessageListViewController.h"//消息

@interface AppointmentOrderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HorizontalCollectionLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AppointmentOrderViewController


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
    
    [self.tableView removeFromSuperview];
    
    
    [self.view addSubview:self.collectionView];
    CGFloat bottomMargin = _type == AppointmentOrderViewControllerType_ChooseType ? 0 : -TABBAR_HEIGHT;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomMargin);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:_type == AppointmentOrderViewControllerType_ChooseType ? @"选择类型" : @"发布需求"];
    if (_type == AppointmentOrderViewControllerType_Default) {
        [self.customNavBar setRightButtonWithImage:imageNamed(@"message_read")];
        __weak __typeof(self)weakSelf = self;
        [self.customNavBar setOnClickRightButton:^(UIButton *btn) {
            MessageListViewController *vc = [[MessageListViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20013 params:@{} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[SkillTypesModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.collectionView reloadData];
        }
    } failBlock:^(NSError *error) {
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArr.count > section) {
        SkillTypesModel *typeModel = self.dataArr[section];
        return typeModel.list.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SkillCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SkillCollectionCell reuseIdentifier] forIndexPath:indexPath];
    if (self.dataArr.count > indexPath.section) {
        SkillTypesModel *typeModel = self.dataArr[indexPath.section];
        [cell setModel:typeModel.list[indexPath.row]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SkillsTypeHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SkillsTypeHeaderView reuseIdentifier] forIndexPath:indexPath];
        if (self.dataArr.count > indexPath.section) {
            headerView.typesModel = self.dataArr[indexPath.section];
        }
        return headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        footerView.backgroundColor = COLOR_UI_F0F0F0;
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArr.count > indexPath.section) {
        SkillTypesModel *typeModel = self.dataArr[indexPath.section];
        if (typeModel.list.count > indexPath.row) {
            SkillModel *skill = typeModel.list[indexPath.row];
            if (_type == AppointmentOrderViewControllerType_ChooseType) {
                SearchViewController *vc = [[SearchViewController alloc] init];
                vc.pasId = skill.pasId;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                ReleaseOrderViewController *vc = [[ReleaseOrderViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    NSString *skillName = @" ";
    if (self.dataArr.count > indexPath.section) {
        SkillTypesModel *typeModel = self.dataArr[indexPath.section];
        if (typeModel.list.count > indexPath.row) {
            SkillModel *skill = typeModel.list[indexPath.row];
            skillName = skill.pasName;
        }
    }
    return skillName;
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        PACollectionFlowLayout *layout = [PACollectionFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 10.0;
        layout.interitemSpacing = 4;
        layout.headerViewHeight = [SkillsTypeHeaderView getHeight];
        layout.footerViewHeight = MARGIN_10;
        layout.itemInset = UIEdgeInsetsMake(0, MARGIN_15, 0, MARGIN_15);
        layout.labelFont = KFont(14);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = COLOR_UI_FFFFFF;
        
        [_collectionView registerClass:[SkillCollectionCell class] forCellWithReuseIdentifier:[SkillCollectionCell reuseIdentifier]];//cell
        [_collectionView registerClass:[SkillsTypeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SkillsTypeHeaderView reuseIdentifier]]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        
        
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets =NO;
        }
        
    }
    return _collectionView;
}


@end
