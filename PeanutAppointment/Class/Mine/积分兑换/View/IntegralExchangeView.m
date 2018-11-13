//
//  IntegralExchangeView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "IntegralExchangeView.h"

#import "IntegralExchangeListModel.h"

#define IntegralExchangeViewBtnTag 432


@interface IntegralExchangeView()

@property (nonatomic, strong) UILabel *currentIntegralLabel;

@property (nonatomic, strong) UIView *btnView;

@end

@implementation IntegralExchangeView

#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
    
}
#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    __weak __typeof(self)weakSelf = self;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = imageNamed(@"IntegralExchange_top_bg");
    [self addSubview:imageV];
    
    CGFloat imageVHeight = SCREEN_WIDTH * 200/375.f;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    [self addSubview:self.currentIntegralLabel];
    [self.currentIntegralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(imageV.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.equalTo(weakSelf.currentIntegralLabel.mas_bottom);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UIView *btnView = [[UIView alloc] init];
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    self.btnView = btnView;
    
    
    UILabel *hintLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    hintLabel.numberOfLines = 0;
    hintLabel.text = @"活动规则:兑换成功后从兑换当日开始计算；兑换会员不能转让其他用户；积分兑换成功后不能退回；最终解释权归花生约见所有。";
    [self addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(btnView.mas_bottom);
    }];
    
}

#pragma mark - public -

- (void)setDataArr:(NSMutableArray<IntegralExchangeListModel *> *)dataArr {
    _dataArr = dataArr;
    
    [self.btnView removeAllSubviews];
    
    CGFloat btnH = 30;
    CGFloat btnW = (SCREEN_WIDTH - MARGIN_15 * 3)/2.f;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        IntegralExchangeListModel *model = self.dataArr[i];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 + i%2 * (btnW + MARGIN_15),MARGIN_15 + i/2 * (btnH + MARGIN_15), btnW, btnH)];
        btn.titleLabel.font = KFont(14);
        [btn setTitle:[NSString stringWithFormat:@"%@天会员·消耗%@积分",model.vipNumber,model.xhjf] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        btn.backgroundColor = COLOR_UI_FFFFFF;
        [btn setDefaultCorner];
        [btn setborderColor:COLOR_UI_999999];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = IntegralExchangeViewBtnTag + i;
        [self.btnView addSubview:btn];
    }
    
    CGFloat btnViewHeight = (btnH + MARGIN_15) * ceilf(dataArr.count/2.f) + MARGIN_20;

    [self.btnView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(btnViewHeight);
    }];
    
}

+ (CGFloat )getHeightWithArray:(NSArray<IntegralExchangeListModel *> *)dataArr {
    
    CGFloat imageVHeight = SCREEN_WIDTH * 200/375.f;
    if (dataArr.count == 0) {
        return imageVHeight + 44 + 50;
    } else {
        CGFloat btnH = 30;
        CGFloat btnViewHeight = (btnH + MARGIN_15) * ceilf(dataArr.count/2.f) + MARGIN_20;
        return imageVHeight + 44 + btnViewHeight + 50;
    }
}

#pragma mark - action -

- (void)btnAction:(UIButton *)sender {
    for (UIButton *btn in self.btnView.subviews) {
        if (btn.tag == sender.tag) {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        } else {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        }
    }
    if (self.chooseBlock && self.dataArr.count > sender.tag - IntegralExchangeViewBtnTag) {
        self.chooseBlock(self.dataArr[sender.tag - IntegralExchangeViewBtnTag]);
    }
}

#pragma mark - getter -

- (UILabel *)currentIntegralLabel {
    if (!_currentIntegralLabel) {
        _currentIntegralLabel = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _currentIntegralLabel.text = @"当前积分 0";
    }
    return _currentIntegralLabel;
}

@end
