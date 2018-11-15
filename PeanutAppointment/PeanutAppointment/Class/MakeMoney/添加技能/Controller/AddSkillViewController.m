//
//  AddSkillViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddSkillViewController.h"
#import "PACollectionFlowLayout.h"
#import "SkillsTypeHeaderView.h"
#import "SkillCollectionCell.h"

#import "SkillTypesModel.h"

#import "AddSkillDetailViewController.h"

@interface AddSkillViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HorizontalCollectionLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *nextBtn;//下一步

@property (nonatomic, strong) NSIndexPath *selectIndexP;

@end

@implementation AddSkillViewController

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

- (void)setupNav {
    [self.customNavBar setTitle:@"添加技能"];
    
}

- (void)setupUI {
    
    [self.tableView removeFromSuperview];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVITETION_HEIGHT);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setButtonStateNormalTitle:@"下一步" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    nextBtn.backgroundColor = COLOR_UI_THEME_RED;
    [nextBtn addTarget:self action:@selector(nextBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.hidden = YES;
    self.nextBtn = nextBtn;
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
}

- (void)updateUI {
    
    if (self.selectIndexP) {
        self.nextBtn.hidden = NO;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
        }];
    } else {
        self.nextBtn.hidden = YES;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
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

#pragma mark - action

- (void)nextBtnClickAction {
    if (self.dataArr.count > _selectIndexP.section) {
        SkillTypesModel *typeModel = self.dataArr[_selectIndexP.section];
        if (typeModel.list.count > _selectIndexP.row) {
            SkillModel *skill = typeModel.list[_selectIndexP.row];
            AddSkillDetailViewController *vc = [[AddSkillDetailViewController alloc] init];
            vc.pasName = skill.pasName;
            vc.pasId = skill.pasId;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
        SkillModel *model = typeModel.list[indexPath.row];
        model.isSelect = indexPath == self.selectIndexP;
        [cell setModel:model];
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
    self.selectIndexP = indexPath;
    [self.collectionView reloadData];
    [self updateUI];
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
