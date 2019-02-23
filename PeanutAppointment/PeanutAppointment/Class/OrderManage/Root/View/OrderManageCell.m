//
//  OrderManageCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "OrderManageCell.h"
#import "UserBaseInfoView.h"

#import "OrderManageDoneListModel.h"

#define kBtnTag 5743

@interface OrderManageCell()

@property (nonatomic, strong) UserBaseInfoView *userView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

@property (nonatomic, strong) OrderManageDoneListModel *model;


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
            [btn setButtonStateNormalTitle:@""];
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

- (void)setModel:(OrderManageDoneListModel * _Nonnull)model isDone:(BOOL)isDone {
    _model = model;
    
    [self.userView.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.userView.typeLevelLabel.text = model.pasName;
    
    self.userView.nickNameLabel.text = model.nikeName;
    self.userView.ageLabel.text = [NSString stringWithFormat:@" %@  ",model.age?:@"18"];
    self.userView.genderLabel.text = [model.sex integerValue] == 1 ? @" 男 " : @" 女 ";
    [self setAuthImageWithModel:model];
    
    self.timeLabel.text = [NSString stringWithFormat:@"发布时间：%@",model.createTime];
    self.hintLabel.hidden = isDone;
    
    if (isDone) {//已完成
        self.userView.distanceLabel.hidden = YES;
        
        self.button3.hidden = [model.state integerValue] != 2;
        
        self.button1.backgroundColor = COLOR_UI_FFFFFF;
        [self.button1 setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        //1:已过期   2:已评价    3:未评价
        if ([model.state integerValue] == 1) {
            [self.button1 setButtonStateNormalTitle:@"已过期"];
        } else {
            [self.button1 setButtonStateNormalTitle:@"已完成"];
        }
        
    } else {//接单中
        self.userView.distanceLabel.hidden = NO;
        self.userView.distanceLabel.text = [NSString stringWithFormat:@"%@KM",model.distance];
        
        self.button3.hidden = YES;
        
        self.button1.backgroundColor = COLOR_UI_THEME_RED;
        [self.button1 setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        
        if ([model.state integerValue] == 2) {
            [self.button1 setButtonStateNormalTitle:@"应邀赚钱"];
        } else {
            [self.button1 setButtonStateNormalTitle:@"发消息"];
        }
    }    
}

#pragma mark - private

- (void)setAuthImageWithModel:(OrderManageDoneListModel *)model {
    
    NSMutableArray *authImages = [NSMutableArray array];
    if (model.phone.length > 0) {//手机认证
        [authImages addObject:imageNamed(@"personalAuth_icon_phone")];
    }
    if (model.wxNumber.length > 0) {//微信认证
        [authImages addObject:imageNamed(@"personalAuth_icon_weichat")];
    }
    if (YES) {//身份认证
        [authImages addObject:imageNamed(@"personalAuth_icon_idCard")];
    }
    if (model.aliPayNumber.length > 0) {//支付宝认证
        [authImages addObject:imageNamed(@"personalAuth_icon_alipay")];
    }
//    if ([model.xxx integerValue] == 1) {//技能认证
//        [authImages addObject:imageNamed(@"personalAuth_icon_skill")];
//    }
    
    [self.userView.authimgLabel setAuthImages:authImages];
}


#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    
    if (self.buttonClickBlock && self.model) {
        self.buttonClickBlock(sender, self.model);
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
