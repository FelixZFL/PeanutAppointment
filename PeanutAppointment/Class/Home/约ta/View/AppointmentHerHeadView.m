//
//  AppointmentHerHeadView.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/25.
//  Copyright © 2018 felix. All rights reserved.
//

#import "AppointmentHerHeadView.h"
#import "HomeIndexUserModel.h"
#import "SkillListModel.h"

#define hintString @"如果约单没有成功，在有效天数过后，订金可退回到本人帐户中，不会对需求发布人造成损失。"

@interface AppointmentHerHeadView()

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *genderLabel;

@property (nonatomic, strong) UIView *priceBtnsView;
@property (nonatomic, strong) UIView *skillsView;

@end

@implementation AppointmentHerHeadView

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
    
    UIView *userView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(65);
    }];
    
    [userView addSubview:self.headImageV];
    [userView addSubview:self.nickNameLabel];
    [userView addSubview:self.ageLabel];
    [userView addSubview:self.genderLabel];
    
    
    __weak __typeof(self)weakSelf = self;
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(userView.mas_centerY);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.headImageV.mas_top);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.bottom.equalTo(weakSelf.headImageV.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.ageLabel.mas_right).with.mas_offset(MARGIN_10);
        make.bottom.equalTo(weakSelf.headImageV.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    
    UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [userView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    
    NSArray *titleArray = @[@"服务订金",@"Ta的技能",@"有效天数"];
    CGFloat marginLeft = 85;
    CGFloat btnHeight = 30;
    UIView *lastView = nil;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(65) : make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(120);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
            make.width.mas_equalTo(60);
        }];
        
        if (i == 0) {
            
            CGFloat btnMarginX = MARGIN_15;
            CGFloat btnWidth = (SCREEN_WIDTH - marginLeft - MARGIN_15 * 4)/4;
            NSArray *titleArray = @[@"50元",@"100元",@"150元",@"200元",@"250元",@"300元",@"350元",@"400元"];
            for (int j = 0; j < titleArray.count; j++) {
                UIButton *btn = [[UIButton alloc] init];
                [btn setButtonStateNormalTitle:titleArray[j] Font:KFont(14) textColor:COLOR_UI_666666];
                [btn setDefaultCorner];
                [btn setborderColor:COLOR_UI_999999];
                [btn addTarget:self action:@selector(priceBtnClcikAction:) forControlEvents:UIControlEventTouchUpInside];
                [singleView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j%4 * (btnWidth + btnMarginX));
                    make.top.mas_equalTo(MARGIN_10 + j/4 * (btnHeight + MARGIN_10));
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }
            
            UILabel *hintLabel = [UILabel labelWithFont:KFont(12) textColor:KHexColor(@"692222") textAlignment:NSTextAlignmentLeft];
            hintLabel.numberOfLines = 0;
            hintLabel.text = hintString;
            [singleView addSubview:hintLabel];
            [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.bottom.mas_equalTo(-MARGIN_10);
            }];
            
            CGFloat btnsHeight = MARGIN_10 + 2 * (btnHeight + MARGIN_10);
            CGFloat hintHeight = [hintString getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(12)];
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(btnsHeight + MARGIN_10 * 2 + hintHeight);
            }];
            
            self.priceBtnsView = singleView;
        } else if (i == 1) {
            
            self.skillsView = singleView;
            
        } else if (i == 2) {
            
            
            CGFloat btnMarginX = MARGIN_15;
            CGFloat btnWidth = (SCREEN_WIDTH - marginLeft - MARGIN_15 * 4)/4;
            NSArray *titleArray = @[@"一天",@"两天",@"三天",@"四天",@"五天",@"六天"];
            for (int j = 0; j < titleArray.count; j++) {
                UIButton *btn = [[UIButton alloc] init];
                [btn setButtonStateNormalTitle:titleArray[j] Font:KFont(14) textColor:COLOR_UI_666666];
                [btn setDefaultCorner];
                [btn setborderColor:COLOR_UI_999999];
                [btn addTarget:self action:@selector(daysBtnClcikAction:) forControlEvents:UIControlEventTouchUpInside];
                [singleView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j%4 * (btnWidth + btnMarginX));
                    make.top.mas_equalTo(MARGIN_10 + j/4 * (btnHeight + MARGIN_10));
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }
            
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(MARGIN_10 + 2 * (btnHeight + MARGIN_10));
            }];
            
        }
        lastView = singleView;
    }
    
}

#pragma mark - public -

+ (CGFloat )getHeightWithModel:(HomeIndexUserModel *)model skills:(NSArray *)skillArray {
    
    if (model) {
        CGFloat btnHeight = 30;
        CGFloat marginLeft = 85;
        CGFloat btnsHeight = MARGIN_10 + 2 * (btnHeight + MARGIN_10);
        CGFloat hintHeight = [hintString getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(12)];
        CGFloat hight1 = btnsHeight + MARGIN_10 * 2 + hintHeight;
        
        CGFloat height2 = 0;
        if (skillArray.count > 0) {
            CGFloat btnX = marginLeft;
            CGFloat btnY = MARGIN_10;
            UIButton *lastBtn = nil;
            NSArray *titleArray = @[@"逛街",@"逛街",@"逛街",@"逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街",@"逛街逛街逛街逛街"];
            UIView *view = [[UIView alloc] init];
            for (int j = 0; j < titleArray.count; j++ ) {
                UIButton *btn = [[UIButton alloc] init];
                [btn setButtonStateNormalTitle:titleArray[j] Font:KFont(14) textColor:COLOR_UI_666666];
                [btn setDefaultCorner];
                [btn setborderColor:COLOR_UI_999999];
                [btn setBackgroundColor:COLOR_UI_FFFFFF];
                [view addSubview:btn];
                CGFloat btnWith = [titleArray[j] getWidthWithMaxSize:CGSizeMake(SCREEN_WIDTH - marginLeft - MARGIN_15 * 3, 15) font:KFont(14)] + MARGIN_15 * 2 ;
                if (btnX + btnWith > SCREEN_WIDTH - MARGIN_15) {
                    btnX = marginLeft;
                    btnY += btnHeight + MARGIN_10;
                }
                btn.frame = CGRectMake(btnX, btnY, btnWith, 30);
                
                btnX = CGRectGetMaxX(btn.frame) + MARGIN_5;
                lastBtn = btn;
            }
            
            height2 = (lastBtn && CGRectGetMaxY(lastBtn.frame) + MARGIN_10 > 35) ? CGRectGetMaxY(lastBtn.frame) + MARGIN_10 : 35;
        }
        
        
        CGFloat height3 = MARGIN_10 + 2 * (btnHeight + MARGIN_10);
        
        return 65 + hight1 + height2 + height3;
        
    }
    return 0;
}

- (void)setModel:(HomeIndexUserModel *)model {
    _model = model;
    
    
}

- (void)setSkillArray:(NSArray<SkillListModel *> *)skillArray {
    _skillArray = skillArray;
    
//    for (UIView *view in self.skillsView.subviews) {
//        [view removeFromSuperview];
//    }
//    CGFloat marginLeft = 85;
//    CGFloat btnX = marginLeft;
//    CGFloat btnY = MARGIN_10;
//    UIButton *lastBtn = nil;
//    NSArray *titleArray = @[@"逛街",@"逛街",@"逛街",@"逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街",@"逛街逛街逛街逛街"];
//    for (int j = 0; j < titleArray.count; j++ ) {
//        UIButton *btn = [[UIButton alloc] init];
//        [btn setButtonStateNormalTitle:titleArray[j] Font:KFont(14) textColor:COLOR_UI_666666];
//        [btn setDefaultCorner];
//        [btn setborderColor:COLOR_UI_999999];
//        [btn setBackgroundColor:COLOR_UI_FFFFFF];
//        [self.skillsView addSubview:btn];
//        [btn addTarget:self action:@selector(skillBtnClcikAction:) forControlEvents:UIControlEventTouchUpInside];
//        CGFloat btnWith = [titleArray[j] getWidthWithMaxSize:CGSizeMake(SCREEN_WIDTH - marginLeft - MARGIN_15 * 3, 15) font:KFont(14)] + MARGIN_15 * 2 ;
//        if (btnX + btnWith > SCREEN_WIDTH - MARGIN_15) {
//            btnX = marginLeft;
//            btnY += btnHeight + MARGIN_10;
//        }
//        btn.frame = CGRectMake(btnX, btnY, btnWith, 30);
//
//        btnX = CGRectGetMaxX(btn.frame) + MARGIN_5;
//        lastBtn = btn;
//    }
//
//    CGFloat height = (lastBtn && CGRectGetMaxY(lastBtn.frame) + MARGIN_10 > 35) ? CGRectGetMaxY(lastBtn.frame) + MARGIN_10 : 35;
//
//    [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
    
}

#pragma mark -- action -

- (void)priceBtnClcikAction:(UIButton *)sender {
    
}

- (void)skillBtnClcikAction:(UIButton *)sender {
    
}

- (void)daysBtnClcikAction:(UIButton *)sender {
    
}


#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        [_nickNameLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _nickNameLabel.text = @"笑笑";
    }
    return _nickNameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        [_ageLabel setLabelFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _ageLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_ageLabel setDefaultCorner];
        _ageLabel.text = @" 23岁 ";
    }
    return _ageLabel;
}

- (UILabel *)genderLabel {
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] init];
        [_genderLabel setLabelFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _genderLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_genderLabel setDefaultCorner];
        _genderLabel.text = @" 男 ";
    }
    return _genderLabel;
}



@end
