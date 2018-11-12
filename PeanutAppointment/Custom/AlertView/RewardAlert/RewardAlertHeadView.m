//
//  RewardAlertHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RewardAlertHeadView.h"
#import "RewardAlertGiftCell.h"
#import "CommodityCountChangeView.h"

#import "RewardModel.h"


@interface RewardAlertHeadView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *diamondNumLabel;
///数量选择
@property (nonatomic, strong) CommodityCountChangeView *countView;


@property (nonatomic, strong) NSMutableArray<RewardGiftListModel *> *giftArray;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation RewardAlertHeadView

#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        _selectIndex = 0;
        [self setupUI];
    }
    return self;
    
}
#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    __weak __typeof(self)weakSelf = self;
    
    UILabel *label = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    label.text = @"余额：";
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.diamondNumLabel];
    [self.diamondNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    UIView *topLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
        make.bottom.equalTo(label);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(topLine.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(LINE_HEIGHT);
        make.bottom.equalTo(weakSelf.collectionView.mas_bottom);
    }];
    
    
    UILabel *countlabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    countlabel.text = @"数量";
    [self addSubview:countlabel];
    [countlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(43);
    }];
    
    [self addSubview:self.countView];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.width.mas_greaterThanOrEqualTo(90);
        make.height.mas_equalTo(CommodityCountChangeViewHeight);
        make.centerY.equalTo(countlabel.mas_centerY);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    
}

#pragma mark - public -

- (void)updateWithModel:(RewardModel *)model {
    self.diamondNumLabel.text = model.masonry;
    self.giftArray = [NSMutableArray arrayWithArray:model.giftList];
    _selectIndex = 0;
    [self.collectionView reloadData];
    [self updateGiftCount];
}

+ (CGFloat)getHeight {
    
    return 30 + 100 + 43;
}

#pragma mark - action -


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.giftArray.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RewardAlertGiftCell *cell = (RewardAlertGiftCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RewardAlertGiftCell reuseIdentifier] forIndexPath:indexPath];
    }
    if (self.giftArray.count > indexPath.row) {
        [cell setModel:self.giftArray[indexPath.row]];
    }
    [cell setborderColor:COLOR_UI_THEME_RED borderWidth:_selectIndex == indexPath.row ? 1 : 0];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath.row;
    [self.collectionView reloadData];
    [_countView setCurrentNum:1];
    [self updateGiftCount];
}

#pragma mark - private

- (void)updateGiftCount {
    NSLog(@"%ld",_countView.currentNum);
    RewardGiftListModel *model = nil;
    if (self.giftArray.count > _selectIndex) {
        model = self.giftArray[_selectIndex];
    }
    if (model == nil) {
        return;
    }
    NSInteger countNum = [model.jzNumber integerValue] * _countView.currentNum;
    
    if (self.chooseGiftChangedBlcok) {
        self.chooseGiftChangedBlcok(countNum);
    }
}

#pragma mark - getter -

- (UILabel *)diamondNumLabel {
    if (!_diamondNumLabel) {
        _diamondNumLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentRight];
        _diamondNumLabel.text = @"0";
    }
    return _diamondNumLabel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CGFloat cellWidth = 55;
        CGFloat cellHeight = cellWidth + 35;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(MARGIN_5, MARGIN_15, MARGIN_5, MARGIN_15);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = COLOR_UI_FFFFFF;
        [_collectionView registerClass:[RewardAlertGiftCell class] forCellWithReuseIdentifier:[RewardAlertGiftCell reuseIdentifier]];
    }
    return _collectionView;
}

- (CommodityCountChangeView *)countView {
    if (!_countView) {
        __weak __typeof(self)weakSelf = self;
        _countView = [[CommodityCountChangeView alloc] init];
        [_countView setChooseNumChangedBlock:^(NSInteger currentNun, CountChangeType type) {
            [weakSelf updateGiftCount];
        }];
    }
    return _countView;
}

@end
