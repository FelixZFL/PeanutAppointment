//
//  RewardAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "RewardAlertView.h"
#import "RewardAlertHeadView.h"
#import "RewardAlertCell.h"
#import "RechargeAlertView.h"

#import "RewardModel.h"

@interface RewardAlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RewardAlertHeadView *headView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RewardModel *model;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) UIButton *diamondCountBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIView *layerView;
///（技能id或者视频id或者直播id）
@property (nonatomic, copy) NSString *ID;
/// 打赏类型
@property (nonatomic, assign) RewardAlertType type;
///被打赏人的id
@property (nonatomic, copy) NSString *bUserId;

///打赏数量
@property (nonatomic, assign) NSInteger rewardCount;

@end

@implementation RewardAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rewardCount = 0;
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    [self addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo([RewardAlertHeadView getHeight]);
    }];
    
    
    [self addSubview:self.tableView];
    
    CGFloat btnH = BUTTON_HEIGHT_50;
    UIView *btnView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(btnH);
    }];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = KFont(14);
        [btnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * SCREEN_WIDTH/2);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.top.bottom.mas_equalTo(0);
        }];
        if (i == 0) {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_222222 forState:UIControlStateNormal];
            [btn setborderColor:COLOR_UI_999999];
            [btn setButtonStateNormalTitle:@"合计 -"];
            self.diamondCountBtn = btn;
        } else {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"确认打赏"];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            self.sureBtn = btn;
        }
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([RewardAlertCell getCellHeight] * 5);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - btnH);
    }];
    
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
    [self getData];
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}
+ (instancetype )alertWithUserId:(NSString *)userId thingsID:(NSString *)ID type:(RewardAlertType )type {
    CGFloat height = [RewardAlertHeadView getHeight] + [RewardAlertCell getCellHeight] * 5 + HOMEBAR_HEIGHT + BUTTON_HEIGHT_50;
    RewardAlertView *alert = [[RewardAlertView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height)];
    alert.bUserId = userId;
    alert.ID = ID;
    alert.type = type;
    return alert;
}

#pragma mark - network -

- (void)getData{
    [YQNetworking postWithApiNumber:API_NUM_20030 params:@{@"userId":[PATool getUserId], @"id":_ID,@"type":@(_type)} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            RewardModel *model = [RewardModel mj_objectWithKeyValues:getResponseData(response)];
            self.model = model;
            [self.headView updateWithModel:model];
            self.dataArr = [NSMutableArray arrayWithArray:model.ranking];
            [self.tableView reloadData];
        } else {
            [self removFromWindow];
        }
    } failBlock:^(NSError *error) {
        [self removFromWindow];
    }];
}


#pragma mark - action -

- (void)btnAction:(UIButton *)sender {
    if (_rewardCount <= 0) {
        return;
    }
    if ([self.model.masonry doubleValue] > _rewardCount) {
        //打赏
        [YQNetworking postWithApiNumber:API_NUM_10021 params:@{@"userId":[PATool getUserId], @"id":_ID,@"type":@(_type),@"bUserId":_bUserId,@"jzNumber":@(_rewardCount)} successBlock:^(id response) {
            if (getResponseIsSuccess(response)) {
                [self getData];
            }
        } failBlock:nil];
    } else {
        //充值
        [self removFromWindow];
        [[RechargeAlertView alert] showInWindow];
    }
    
}


#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RewardAlertCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [RewardAlertCell reuseIdentifier];
    RewardAlertCell *cell = (RewardAlertCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RewardAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row] index:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter
- (RewardAlertHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[RewardAlertHeadView alloc] init];
        [_headView setChooseGiftChangedBlcok:^(NSInteger giftCount) {
            weakSelf.rewardCount = giftCount;
            [weakSelf.diamondCountBtn setButtonStateNormalTitle:[NSString stringWithFormat:@"合计 %ld",giftCount]];
            if ([weakSelf.model.masonry doubleValue] > giftCount) {
                [weakSelf.sureBtn setButtonStateNormalTitle:@"确认打赏"];
            } else {
                [weakSelf.sureBtn setButtonStateNormalTitle:@"充值"];
            }
        }];
    }
    return _headView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = COLOR_UI_FFFFFF;
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArr;
}

@end
