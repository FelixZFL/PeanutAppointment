//
//  DemandDetailCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "DemandDetailCell.h"
#import "UserBaseInfoView.h"

#import "DemanDetailModel.h"

#define kBtnTag 57376

@interface DemandDetailCell()

@property (nonatomic, strong) UserBaseInfoView *userView;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *personIndouceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@end

@implementation DemandDetailCell

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
    
    __weak __typeof(self)weakSelf = self;
    
    UIView *whiteBgView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self addSubview:whiteBgView];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-MARGIN_10);
    }];
    
    CGFloat userHeight = [UserBaseInfoView getHeight];
    
    [whiteBgView addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(userHeight);
    }];
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [whiteBgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.equalTo(weakSelf.userView.mas_bottom);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    CGFloat marginLeft = 85;

    NSArray *titleArray = @[@"线下服务",@"Ta的优势",@"应邀时间"];
    UIView *lastView = nil;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [whiteBgView addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(userHeight) : make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(35);
        }];

        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [singleView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];

        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        titleLabel.numberOfLines = 0;
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
            make.width.mas_equalTo(60);
        }];
        [titleLabel changeAligmentRightAndLeftWithWidth:60];

        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        [singleView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft);
            make.right.mas_equalTo(-MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
        }];

        if (i == 0) {
            //contentLabel.text = @"256.00元/小时";
            self.priceLabel = contentLabel;
        } else if (i == 1) {
            
            self.personIndouceLabel = contentLabel;
        } else if (i == 2) {
            //contentLabel.text = @"2018-08-31 05:25:25";
            self.timeLabel = contentLabel;
        }
        lastView = singleView;
    }
    
    
    NSArray *btnArray = @[@"去评价",@"付余款",@"申请退款",@"发消息"];
    CGFloat btnWith = 66;
    CGFloat btnHeight = 30;
    CGFloat marginX = (SCREEN_WIDTH - MARGIN_15 * 2 - btnWith * btnArray.count)/(btnArray.count + 1);
    
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [self getSingleBtn];
        [btn setButtonStateNormalTitle:btnArray[i]];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteBgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-marginX - i * (btnWith + marginX));
            make.bottom.mas_equalTo(-MARGIN_15);
            make.width.mas_equalTo(btnWith);
            make.height.mas_equalTo(btnHeight);
        }];
        if (i == 0) {
            self.button1 = btn;
        } else if (i == 1) {
            self.button2 = btn;
        } else if (i == 2) {
            self.button3 = btn;
        } else if (i == 3) {
            self.button4 = btn;
            btn.selected = YES;
        }
    }
    self.bottomLine.hidden = YES;
}

#pragma mark - public -
+ (CGFloat)getCellHeightWithModel:(DemanDetailModel *)model {
    CGFloat marginLeft = 85;
    CGFloat contentHeight = MAX([model.experience getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 * 3 font:KFont(14)] + MARGIN_10 * 2, 35) ;
    return [UserBaseInfoView getHeight] + 35 * 2 + contentHeight + MARGIN_15 * 2 + 30 + MARGIN_10;
}

- (void)setModel:(DemanDetailModel *)model {
    _model = model;
    
    [self.userView.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.userView.typeLevelLabel.text = model.pasName;
    self.userView.nickNameLabel.text = model.nikeName;
    self.userView.ageLabel.text = [NSString stringWithFormat:@" %@  ",model.age];
    self.userView.genderLabel.text = [model.sex integerValue] == 1 ? @" 男 " : @" 女 ";
    [self setAuthImageWithModel:model];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",model.servicePrice];
    
    self.personIndouceLabel.text = model.experience;
    CGFloat marginLeft = 85;
    CGFloat contentHeight = MAX([model.experience getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 * 3 font:KFont(14)] + MARGIN_10 * 2, 35) ;
    [self.personIndouceLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentHeight);
    }];
    
    self.timeLabel.text = model.yyTIme;
    
}

#pragma mark - private -

- (void)setAuthImageWithModel:(DemanDetailModel *)model {
    
    NSMutableArray *authImages = [NSMutableArray array];
    if (model.phone.length > 0) {//手机认证
        [authImages addObject:imageNamed(@"personalAuth_icon_phone")];
    }
    if (model.wxNumber.length > 0) {//微信认证
        [authImages addObject:imageNamed(@"personalAuth_icon_weichat")];
    }
//    if (YES) {//身份认证
//        [authImages addObject:imageNamed(@"personalAuth_icon_idCard")];
//    }
    if (model.aliPayNumber.length > 0) {//支付宝认证
        [authImages addObject:imageNamed(@"personalAuth_icon_alipay")];
    }
    //    if ([model.xxx integerValue] == 1) {//技能认证
    //        [authImages addObject:imageNamed(@"personalAuth_icon_skill")];
    //    }
    
    [self.userView.authimgLabel setAuthImages:authImages];
}

- (UIButton *)getSingleBtn {
    UIButton *btn = [[UIButton alloc] init];
    [btn setButtonStateNormalTitle:@"" Font:KFont(14) textColor:COLOR_UI_666666];
    [btn setborderColor:COLOR_UI_999999];
    [btn setDefaultCorner];
    [btn setBackgroundImage:[UIImage createImageWithColor:COLOR_UI_FFFFFF] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage createImageWithColor:COLOR_UI_THEME_RED] forState:UIControlStateSelected];
    [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateSelected];
    return btn;
}



#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    
}

#pragma mark - getter -

- (UserBaseInfoView *)userView {
    if (!_userView) {
        _userView = [[UserBaseInfoView alloc] init];
        _userView.distanceLabel.hidden = YES;
    }
    return _userView;
}

@end
