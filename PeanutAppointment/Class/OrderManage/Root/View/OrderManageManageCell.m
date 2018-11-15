//
//  OrderManageManageCell.m
//  PeanutAppointment
//
//  Created by felix on 2018/9/30.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "OrderManageManageCell.h"
#import "TitleImageButton.h"

#import "OrderManageListModel.h"

@interface OrderManageManageCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *guoqiLabel;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<OrderManageInvitedListModel *> *dataArr;

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

+ (CGFloat)getCellHeightWithModel:(OrderManageListModel *)model {
    CGFloat oneHeight = 38;
    CGFloat titleWidth = 70;
    CGFloat headWidth = 30;
    
    CGFloat height = MARGIN_15 + oneHeight * 3 + MARGIN_10;
    
    if (model.invitedList > 0) {
        
        NSInteger count = floorf((ScreenWidth - titleWidth + MARGIN_15 * 3 + MARGIN_10)/(headWidth + MARGIN_10));
        NSInteger lineNum = ceilf((model.invitedList.count /(float)count));
        height += lineNum * (headWidth + MARGIN_10);
    } else {
        height += oneHeight;
    }
    
    return height;
}

- (void)setModel:(OrderManageListModel *)model {
    _model = model;
    
    self.typeLabel.text = model.pasName;
    self.timeLabel.text = model.createTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [dateFormatter dateFromString:model.createTime];
    NSDate *endDate = [NSDate dateWithTimeInterval:[model.dayNumber integerValue] * 24 * 60 * 60 sinceDate:startDate];
    NSDate *nowDate = [NSDate date];
    if ([nowDate compare:endDate] == NSOrderedAscending) {
        //结束时间 比现在 时间大 意味着时间没过期
        NSInteger second = floor([endDate timeIntervalSinceDate:nowDate]);
        NSInteger days = ceilf(second/(24 * 60 * 60.f));
        self.guoqiLabel.text = [NSString stringWithFormat:@"%ld后过期",days];
    } else {
        //已过期
        self.guoqiLabel.text = @"0天后过期";
    }
    if (model.invitedList.count > 0) {
        self.dataArr = model.invitedList;
        [self.collectionView reloadData];
        
        self.collectionView.hidden = NO;
    } else {
        self.collectionView.hidden = YES;
    }
}


#pragma mark - ============= UICollectionViewDataSource,UICollectionViewDelegate ===============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderManageManageHeadCell *cell = (OrderManageManageHeadCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[OrderManageManageHeadCell reuseIdentifier] forIndexPath:indexPath];
    }
    if (self.dataArr.count > indexPath.row) {
        OrderManageInvitedListModel *model = self.dataArr[indexPath.row];
        [cell.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        cell.redDotView.hidden = [model.isQuery integerValue] == 1;
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
