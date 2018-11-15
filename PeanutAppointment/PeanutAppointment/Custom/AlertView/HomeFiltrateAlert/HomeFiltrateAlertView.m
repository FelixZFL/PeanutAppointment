//
//  HomeFiltrateAlertView.m
//  PeanutAppointment
//
//  Created by felix on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import "HomeFiltrateAlertView.h"

#define  FiltrateAlertViewHeight 310

#define kSexBtnTag 7584
#define kAgeBtnTag 57689
#define kDistanceBtnTag 4536


@interface HomeFiltrateAlertView()

@property (nonatomic, copy) ChooseFiltrateBlock chooseBlock;
@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIView *sexView;//性别视图
@property (nonatomic, strong) UIView *ageView;//年龄段视图
@property (nonatomic, strong) UIView *distanceView;//距离视图

@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *distance;

@end

@implementation HomeFiltrateAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    
    CGFloat marginLeft = 60;
    NSArray *titleArray = @[@"性别",@"年龄",@"距离"];
    CGFloat btnHeight = 30;
    CGFloat viewHeight = 50;
    
    _sex = _age = _distance = @"";
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(viewHeight * i);
            make.height.mas_equalTo(viewHeight);
        }];
        
        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [singleView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(45);
        }];
        
        NSArray *nameArray = @[];
        NSInteger tag = 0;
        SEL action = nil;
        CGFloat btnWidth = 50;
        if (i == 0) {
            nameArray = @[@"不限",@"男",@"女"];
            tag = kSexBtnTag;
            action = @selector(sexBtnClcikAction:);
            self.sexView = singleView;
        } else if (i == 1) {
            nameArray = @[@"不限",@"小于25",@"25-35",@"大于35"];
            tag = kAgeBtnTag;
            action = @selector(ageBtnClcikAction:);
            btnWidth = 60;
            self.ageView = singleView;
        } else if (i == 2) {
            nameArray = @[@"不限",@"5公里以内",@"10公里以内"];
            tag = kDistanceBtnTag;
            action = @selector(distanceBtnClcikAction:);
            btnWidth = 80;
            self.distanceView = singleView;
        }
        for (int j = 0; j < nameArray.count; j++) {
            UIButton *btn = [self getSingleBtn];
            [btn setButtonStateNormalTitle:nameArray[j]];
            btn.selected = j == 0;
            btn.tag = tag + j;
            [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            [singleView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(j == 0 ? marginLeft : marginLeft + 50 + MARGIN_10 +  (j - 1)* (btnWidth + MARGIN_10));
                make.centerY.equalTo(singleView);
                make.width.mas_equalTo(j == 0 ? 50 : btnWidth);
                make.height.mas_equalTo(btnHeight);
            }];
        }
    }
    
    
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
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
            [btn setborderColor:COLOR_UI_999999];
            [btn setButtonStateNormalTitle:@"重置"];
            [btn addTarget:self action:@selector(resetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"确认"];
            [btn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
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
    self.y = window.height - FiltrateAlertViewHeight;
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithBlock:(ChooseFiltrateBlock)block {
    HomeFiltrateAlertView *alert = [[HomeFiltrateAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FiltrateAlertViewHeight)];
    alert.chooseBlock = block;
    return alert;
}

#pragma mark - action -

- (void)sexBtnClcikAction:(UIButton *)sender {
    //sex：性别（1:男 /0:女）
    if (sender.tag - kSexBtnTag == 1) {//男
        self.sex = @"1";
    } else if (sender.tag - kSexBtnTag == 2) {//女
        self.sex = @"0";
    } else {
        self.sex = @"";
    }
    [self seleBtn:sender];
}
- (void)ageBtnClcikAction:(UIButton *)sender {
    // age：25 25-35 35（25：小于25 25-35 35:小于35）
    if (sender.tag - kSexBtnTag == 1) {//@"小于25"
        self.age = @"25";
    } else if (sender.tag - kSexBtnTag == 2) {//@"25-35"
        self.age = @"25-35";
    } else if (sender.tag - kSexBtnTag == 3) {//@"大于35"
        self.age = @"35";
    } else {
        self.age = @"";
    }
    [self seleBtn:sender];
}
- (void)distanceBtnClcikAction:(UIButton *)sender {
    //distance：距离 （单位：公里）
    if (sender.tag - kDistanceBtnTag == 1) {//5公里以内
        self.distance = @"5";
    } else if (sender.tag - kDistanceBtnTag == 2) {//10公里以内
        self.distance = @"10";
    } else {
        self.distance = @"";
    }
    [self seleBtn:sender];
}


//重置
- (void)resetBtnAction:(UIButton *)sender {
    
    [self sexBtnClcikAction:[self.sexView viewWithTag:kSexBtnTag]];
    [self ageBtnClcikAction:[self.ageView viewWithTag:kAgeBtnTag]];
    [self distanceBtnClcikAction:[self.distanceView viewWithTag:kDistanceBtnTag]];
}
//确认
- (void)okBtnAction:(UIButton *)sender {
    
    if (self.chooseBlock) {
        self.chooseBlock(self.sex, self.age, self.distance);
    }
    
    [self removFromWindow];
}


#pragma mark - private

- (void)seleBtn:(UIButton *)sender {
    for (UIView *view in sender.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (sender == view) {
                [(UIButton *)view setSelected:YES];
            } else {
                [(UIButton *)view setSelected:NO];
            }
        }
    }
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


@end
