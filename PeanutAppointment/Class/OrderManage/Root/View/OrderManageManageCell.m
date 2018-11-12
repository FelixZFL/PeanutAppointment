//
//  OrderManageManageCell.m
//  PeanutAppointment
//
//  Created by felix on 2018/9/30.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "OrderManageManageCell.h"
#import "TitleImageButton.h"

@interface OrderManageManageCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *guoqiLabel;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation OrderManageManageCell

#pragma mark - lifeCycle -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_F0F0F0;
    
    UIView *bgView = [UIView viewDefaultCornerWithColor:COLOR_UI_FFFFFF];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(MARGIN_15);
        make.bottom.mas_equalTo(0);
    }];
    
    CGFloat oneHeight = 38;
    CGFloat titleWidth = 70;
    for (int i = 0 ; i < 3; i++) {
        
        UIView *view = [[UIView alloc] init];
        [bgView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i * oneHeight);
            make.height.mas_equalTo(oneHeight);
        }];
        
        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.height.mas_equalTo(LINE_HEIGHT);
            make.bottom.mas_equalTo(0);
        }];
        
        
        UILabel *label = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.width.mas_equalTo(titleWidth);
            make.top.bottom.mas_equalTo(0);
        }];
        [label setText:@[@"类别",@"发布时间",@"状态"][i]];
        [label changeAligmentRightAndLeftWithWidth:titleWidth];
        
        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        [view addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).with.mas_offset(MARGIN_15);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(i == 2 ? -MARGIN_15 : -100);
        }];
        
        if (i == 0) {
            TitleImageButton *nextBtn = [TitleImageButton buttonWithTitle:@"查看详情"];
            [view addSubview:nextBtn];
            [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-MARGIN_15);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_greaterThanOrEqualTo(0);
            }];
            contentLabel.text = @"棋牌";
        } else if (i == 1) {
            _guoqiLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentRight];
            _guoqiLabel.text = @"29天后过期";
            [view addSubview:_guoqiLabel];
            [_guoqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-MARGIN_15);
                make.top.bottom.mas_equalTo(0);
                make.width.mas_greaterThanOrEqualTo(0);
            }];
            contentLabel.text = @"2018-08-30 03:25";
        } else {
            contentLabel.text = @"未成交·等待服务者应邀";
        }
        
    }
    
    CGFloat topHeight = 3*oneHeight;
    
    UILabel *serverLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    [bgView addSubview:serverLabel];
    [serverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.width.mas_equalTo(titleWidth);
        make.top.mas_equalTo(topHeight + MARGIN_10);
    }];
    [serverLabel setText:@"应邀服务者"];
    [serverLabel changeAligmentRightAndLeftWithWidth:titleWidth];
    
    CGFloat headWidth = 30;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(headWidth,headWidth);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[OrderManageManageHeadCell class] forCellWithReuseIdentifier:[OrderManageManageHeadCell reuseIdentifier]];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = COLOR_UI_FFFFFF;
    [bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topHeight);
        make.right.mas_equalTo(-MARGIN_15);
        make.left.mas_equalTo(titleWidth + MARGIN_15 * 2);
        make.bottom.mas_equalTo(0);
    }];
    
    
    self.bottomLine.hidden = YES;
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    CGFloat oneHeight = 38;
    CGFloat headWidth = 30;
    return MARGIN_15 + oneHeight * 3  + headWidth * 2 + MARGIN_10 * 3;
}



#pragma mark - ============= UICollectionViewDataSource,UICollectionViewDelegate ===============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderManageManageHeadCell *cell = (OrderManageManageHeadCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[OrderManageManageHeadCell reuseIdentifier] forIndexPath:indexPath];
    }
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end


@implementation OrderManageManageHeadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headImageV = [[UIImageView alloc] init];
        [self.headImageV setCorner:15.f];
        self.headImageV.image = imageNamed(placeHolderHeadImageName);
        [self addSubview:self.headImageV];
        [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        self.redDotView = [UIView viewWithColor:KColor(redColor)];
        [self.redDotView setCorner:3.f];
        [self addSubview:self.redDotView];
        [self.redDotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(6.f);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-MARGIN_5);
        }];
        
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}


@end
