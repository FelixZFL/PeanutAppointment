//
//  UserMainPageHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserMainPageHeadView.h"

@interface UserMainPageHeadView()

@end

@implementation UserMainPageHeadView

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
    imageV.backgroundColor = KColor(blackColor);
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
    
    CGFloat marginLeft = 85;
    
    NSArray *titleArray = @[@"用户昵称",@"地理位置",@"个人相册",@"认证",@"等级积分",@"访客量",@"Ta的技能"];
    UIView *lastView = imageV;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(lastView.mas_bottom);
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
        
        if (i == 0) {
            
            UILabel *nameLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.centerY.equalTo(titleLabel);
            }];
            nameLabel.text = @"笑笑";
            
            UILabel *ageLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
            ageLabel.backgroundColor = COLOR_UI_THEME_RED;
            [ageLabel setDefaultCorner];
            [singleView addSubview:ageLabel];
            [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameLabel.mas_right).with.mas_offset(MARGIN_10);
                make.centerY.equalTo(nameLabel);
            }];
            ageLabel.text = @" 23岁 ";
            
            UILabel *genderLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
            genderLabel.backgroundColor = COLOR_UI_THEME_RED;
            [genderLabel setDefaultCorner];
            [singleView addSubview:genderLabel];
            [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ageLabel.mas_right).with.mas_offset(MARGIN_10);
                make.centerY.equalTo(ageLabel);
            }];
            genderLabel.text = @" 女 ";
            
            UILabel *distanceLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
            [singleView addSubview:distanceLabel];
            [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            distanceLabel.text = @"10KM";
            
            
        } else if (i == 1) {
            UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
            contentLabel.numberOfLines = 0;
            [singleView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.top.mas_equalTo(MARGIN_10);
            }];
            NSString *contentStr = @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件";
            contentLabel.text = contentStr;
            CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(contentHeight);
                }];
            }
        } else if (i == 2) {
            CGFloat imgWidth = 30;
            for (int j = 0; j < 6; j++) {
                UIImageView *imageV = [[UIImageView alloc] init];
                imageV.backgroundColor = COLOR_UI_000000;
                [imageV setDefaultCorner];
                [singleView addSubview:imageV];
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j * (imgWidth + MARGIN_5));
                    make.top.mas_equalTo((42 - imgWidth)/2.f);
                    make.width.mas_equalTo(imgWidth);
                    make.height.mas_equalTo(imgWidth);
                }];
            }
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(42);
            }];
        } else if (i == 3) {
            UILabel *authimgLabel = [[UILabel alloc] init];
            //实现富文本
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
            for (int i = 0; i < 3; i++) {
                //进行图文混排
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
                textAttachment.image = [UIImage imageNamed:@"mine_icon_vip"];
                textAttachment.bounds =CGRectMake(0,0, 16,16);
                NSAttributedString * textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
                [string insertAttributedString:textAttachmentString atIndex:string.length];
            }
            authimgLabel.attributedText = string;
            [singleView addSubview:authimgLabel];
            [authimgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
        } else if (i == 4) {
            UILabel *jifenLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:jifenLabel];
            [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            jifenLabel.text = @"256362";
        } else if (i == 5) {
            UILabel *visitorCountLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:visitorCountLabel];
            [visitorCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            visitorCountLabel.text = @"256362";
            
            CGFloat imgWidth = 30;
            NSInteger count = floorf((SCREEN_WIDTH - marginLeft - MARGIN_15 + MARGIN_5)/(imgWidth + MARGIN_5));
            for (int j = 0; j < count; j++) {
                UIImageView *imageV = [[UIImageView alloc] init];
                imageV.backgroundColor = COLOR_UI_000000;
                [imageV setCorner:imgWidth/2.f];
                [singleView addSubview:imageV];
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j * (imgWidth + MARGIN_5));
                    make.top.mas_equalTo(35);
                    make.width.mas_equalTo(imgWidth);
                    make.height.mas_equalTo(imgWidth);
                }];
            }
            
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(35 + imgWidth + MARGIN_10);
            }];
        } else if (i == 6) {
            
            CGFloat btnX = marginLeft;
            CGFloat btnY = MARGIN_10;
            CGFloat btnHeight = 30;
            UIButton *lastBtn = nil;
            NSArray *titleArray = @[@"逛街",@"逛街",@"逛街",@"逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街",@"逛街逛街逛街逛街"];
            for (int j = 0; j < titleArray.count; j++ ) {
                UIButton *btn = [[UIButton alloc] init];
                [btn setButtonStateNormalTitle:titleArray[j] Font:KFont(14) textColor:COLOR_UI_666666];
                [btn setDefaultCorner];
                [btn setborderColor:COLOR_UI_999999];
                [btn setBackgroundColor:COLOR_UI_FFFFFF];
                [singleView addSubview:btn];
                CGFloat btnWith = [titleArray[j] getWidthWithMaxSize:CGSizeMake(SCREEN_WIDTH - marginLeft - MARGIN_15 * 3, 15) font:KFont(14)] + MARGIN_15 * 2 ;
                
                if (btnX + btnWith > SCREEN_WIDTH - MARGIN_15) {
                    btnX = marginLeft;
                    btnY += btnHeight + MARGIN_10;
                }
                btn.frame = CGRectMake(btnX, btnY, btnWith, 30);
                
                btnX = CGRectGetMaxX(btn.frame) + MARGIN_5;
                lastBtn = btn;
            }
            
            CGFloat height = (lastBtn && CGRectGetMaxY(lastBtn.frame) + MARGIN_10 > 35) ? CGRectGetMaxY(lastBtn.frame) + MARGIN_10 : 35;
            
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
        }
        lastView = singleView;
    }
    
    UIView *bottomLine = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat marginLeft = 85;
    CGFloat imgWidth = 30;
    NSString *contentStr = @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件";
    CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
    CGFloat height2 = contentHeight > 35 ? contentHeight : 35;
    CGFloat height3 = 42;
    CGFloat height6 = 35 + imgWidth + MARGIN_10;
    
    
    CGFloat btnX = marginLeft;
    CGFloat btnY = MARGIN_10;
    CGFloat btnHeight = 30;
    UIButton *lastBtn = nil;
    NSArray *titleArray = @[@"逛街",@"逛街",@"逛街",@"逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街逛街逛街",@"逛街逛街逛街逛街逛街逛街逛街逛街逛街逛街",@"逛街逛街",@"逛街逛街逛街逛街"];
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
    
    CGFloat height7 = (lastBtn && CGRectGetMaxY(lastBtn.frame) + MARGIN_10 > 35) ? CGRectGetMaxY(lastBtn.frame) + MARGIN_10 : 35;
    return  SCREEN_WIDTH + 35 * 3 + height2 + height3 + height6 + height7 + MARGIN_10;
}

#pragma mark - getter -

@end
