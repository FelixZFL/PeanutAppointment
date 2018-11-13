//
//  MakeMoneyHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MakeMoneyHeadView.h"

#define MakeMoneyHeadViewBtnTag 111

@interface MakeMoneyHeadView()

@end

@implementation MakeMoneyHeadView

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
    imageV.image = imageNamed(@"MakeMoney_top_bg");
    [self addSubview:imageV];
    
    CGFloat imageVHeight = SCREEN_WIDTH * 150/375.f;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    
    NSArray *btnNameArr = @[@"添加技能",@"上传视频",@"个人认证",@"上传相册",@"上传头像"];
    NSArray *btnImageArr = @[@"makeMoney_btn_addSkill",@"makeMoney_btn_uploadVideo",@"makeMoney_btn_persionAuth",@"makeMoney_btn_uploadPhoto",@"makeMoney_btn_uploadHead"];
    
    NSInteger column = 5;
    
    CGFloat btnW = SCREEN_WIDTH/column;
    CGFloat btnH = 110;
    
    CGFloat btnViewHeight = btnH * (btnNameArr.count / column);
    
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = COLOR_UI_FFFFFF;
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(imageV.mas_bottom);
        make.height.mas_equalTo(btnViewHeight);
    }];
    for (int i = 0; i < btnNameArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%column * btnW, i/column * btnH, btnW, btnH)];
        [btn setTitle:btnNameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateHighlighted];
        btn.titleLabel.font = KFont(12);
        btn.backgroundColor = COLOR_UI_FFFFFF;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = MakeMoneyHeadViewBtnTag + i;
        [btn verticalImageAndTitle:MARGIN_5];
        [btnView addSubview:btn];
    }
    
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat imageVHeight = SCREEN_WIDTH * 150/375.f;
    CGFloat btnH = 110;
    return imageVHeight + btnH;
}

#pragma mark - action -

- (void)btnAction:(UIButton *)btn {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(btn.tag - MakeMoneyHeadViewBtnTag);
    }
}

#pragma mark - getter -

@end
