    //
//  MyAccountHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyAccountHeadView.h"
#import "MyAccountInfoModel.h"

@interface MyAccountHeadView()

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *rebateLabel;//返利统计
@property (nonatomic, strong) UILabel *balanceLabel;//余额

@property (nonatomic, strong) UILabel *redBalanceLabel;//红包余额
@property (nonatomic, strong) UILabel *wattingMoneyLabel;//未到账

@end

@implementation MyAccountHeadView

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
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.backgroundColor = COLOR_UI_999999;
    [self addSubview:imageV];
    
    CGFloat imageVHeight = SCREEN_WIDTH * 212/375.f;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    
    [self addSubview:self.headImageV];
    [self addSubview:self.nameLabel];
    
    __weak __typeof(self)weakSelf = self;
    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imageV);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImageV.mas_bottom).with.mas_offset(MARGIN_10);
        make.centerX.equalTo(weakSelf);
    }];
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomLine.mas_top);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(62);
    }];
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] init];
        [bottomView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * SCREEN_WIDTH/2);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(0);
        }];
        UILabel *moneyLabel = [UILabel labelWithFont:KFont(15) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.bottom.mas_equalTo(-MARGIN_10);
            make.right.mas_equalTo(0);
        }];
        if (i == 0) {
            UIView *vLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
            [view addSubview:vLine];
            [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.centerY.equalTo(view);
                make.width.mas_equalTo(LINE_HEIGHT);
                make.height.mas_equalTo(24);
            }];
            titleLabel.text = @"返利统计";
            moneyLabel.text = @"￥0.00";
            self.rebateLabel = moneyLabel;
        } else {
            titleLabel.text = @"余额";
            moneyLabel.text = @"￥0.00";
            self.balanceLabel = moneyLabel;
        }
    }
    
    
    UIView *popView = [UIView viewWithColor:COLOR_UI_THEME_RED];
    [popView setCorner:CORNER_5];
    [self addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top);
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.height.mas_equalTo(60);
    }];
    
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] init];
        [popView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * (SCREEN_WIDTH/2 - 38));
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH/2 - 38);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(0);
        }];
        UILabel *moneyLabel = [UILabel labelWithFont:KFont(15) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.bottom.mas_equalTo(-MARGIN_10);
            make.right.mas_equalTo(0);
        }];
        if (i == 0) {
            UIView *vLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
            [view addSubview:vLine];
            [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.centerY.equalTo(view);
                make.width.mas_equalTo(LINE_HEIGHT);
                make.height.mas_equalTo(34);
            }];
            titleLabel.text = @"红包余额";
            moneyLabel.text = @"￥0.00";
            self.redBalanceLabel = moneyLabel;
        } else {
            titleLabel.text = @"未到账详情";
            moneyLabel.text = @"￥0.00";
            self.wattingMoneyLabel = moneyLabel;
        }
    }
    
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat imageVHeight = SCREEN_WIDTH * 212/375.f;

    return imageVHeight + 80 + MARGIN_10;
}

- (void)updateWithModel:(MyAccountInfoModel *)model {
    [self.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.nameLabel.text = model.nikeName;
    
    self.rebateLabel.text = [NSString stringWithFormat:@"￥%@",model.rebate];
    self.balanceLabel.text = [NSString stringWithFormat:@"￥%@",model.balanceOutstanding];

    self.redBalanceLabel.text = [NSString stringWithFormat:@"￥%@",model.redPacket];
    self.wattingMoneyLabel.text = [NSString stringWithFormat:@"￥%@",model.notAccount];

}

#pragma mark - action -

#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setLabelFont:KFont(14) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}


@end
