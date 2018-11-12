//
//  OrderManageCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "OrderManageCell.h"
#import "UserBaseInfoView.h"

#define kBtnTag 5743

@interface OrderManageCell()

@property (nonatomic, strong) UserBaseInfoView *userView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@end

@implementation OrderManageCell

#pragma mark - lifeCycle -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    
    [self addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo([UserBaseInfoView getHeight]);
    }];
    [self.userView.distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(-MARGIN_10);
    }];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.userView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.left.equalTo(weakSelf.userView.typeLevelLabel.mas_right);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self.userView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    
    [self addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.equalTo(weakSelf.userView.mas_bottom);
        make.bottom.mas_equalTo(-MARGIN_10);
        make.width.mas_equalTo(130);
    }];
    
    
    CGFloat buttonWidth = 70;
    CGFloat buttonHeight = 30;
    
    for (int i = 0; i < 3; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setButtonStateNormalTitle:@"" Font:KFont(12) textColor:COLOR_UI_666666];
        [btn setDefaultCorner];
        [btn setborderColor:COLOR_UI_999999 borderWidth:LINE_HEIGHT];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-MARGIN_15 - (MARGIN_15 + buttonWidth) * i);
            make.top.equalTo(weakSelf.userView.mas_bottom).with.mas_offset(MARGIN_10);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
        }];
        
        
        if (i == 0) {
            [btn setButtonStateNormalTitle:@"已完成"];
            self.button1 = btn;
        } else if (i == 1) {
            [btn setButtonStateNormalTitle:@"删除订单"];
            self.button2 = btn;
        } else {
            [btn setButtonStateNormalTitle:@"去评价"];
            self.button3 = btn;
        }
        
    }
    
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MARGIN_10);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return [UserBaseInfoView getHeight] + 50 + MARGIN_10;
}

#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag - kBtnTag);
    }
    
}

#pragma mark - getter -

- (UserBaseInfoView *)userView {
    if (!_userView) {
        _userView = [[UserBaseInfoView alloc] init];
    }
    return _userView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
        _timeLabel.text = @"发布时间：08/30 20：00";
    }
    return _timeLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        [_hintLabel setLabelFont:KFont(10) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _hintLabel.numberOfLines = 0;
        _hintLabel.text = @"为了保证您的权益，对方 将订金支付到平台后再去见面";
    }
    return _hintLabel;
}


@end
