//
//  UserMainPageHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserMainPageHeadView.h"

#import "UserMainPageModel.h"

@interface UserMainPageHeadView()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIView *photosView;//个人相册
@property (nonatomic, strong) UILabel *authLabel;//认证信息
@property (nonatomic, strong) UILabel *visitorCountLabel;
@property (nonatomic, strong) UILabel *visitorCountView;//访客量视图
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
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
    self.imageV = imageV;
    
    CGFloat marginLeft = 85;
    
    NSArray *titleArray = @[@"用户昵称",@"地理位置",@"个人相册",@"认证",@"访客量",@"Ta的技能"];
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
            self.nameLabel = nameLabel;
//            nameLabel.text = @"笑笑";

            UILabel *ageLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
            ageLabel.backgroundColor = COLOR_UI_THEME_RED;
            [ageLabel setDefaultCorner];
            [singleView addSubview:ageLabel];
            [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameLabel.mas_right).with.mas_offset(MARGIN_10);
                make.centerY.equalTo(nameLabel);
            }];
            self.ageLabel = ageLabel;
//            ageLabel.text = @" 23岁 ";
            
            UILabel *genderLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
            genderLabel.backgroundColor = COLOR_UI_THEME_RED;
            [genderLabel setDefaultCorner];
            [singleView addSubview:genderLabel];
            [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ageLabel.mas_right).with.mas_offset(MARGIN_10);
                make.centerY.equalTo(ageLabel);
            }];
            self.genderLabel = genderLabel;
//            genderLabel.text = @" 女 ";
            
            UILabel *distanceLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
            [singleView addSubview:distanceLabel];
            [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            self.distanceLabel = distanceLabel;
//            distanceLabel.text = @"10KM";
            
            
        } else if (i == 1) {
            UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
            contentLabel.numberOfLines = 0;
            [singleView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.top.mas_equalTo(MARGIN_10);
            }];
            self.addressLabel = contentLabel;
        } else if (i == 2) {
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(42);
            }];
            self.photosView = singleView;
        } else if (i == 3) {
            UILabel *authimgLabel = [[UILabel alloc] init];
            [authimgLabel setLabelFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:authimgLabel];
            [authimgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            self.authLabel = authimgLabel;
        }
//        else if (i == 4) {
//            UILabel *jifenLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
//            [singleView addSubview:jifenLabel];
//            [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(marginLeft);
//                make.right.mas_equalTo(-MARGIN_15);
//                make.centerY.equalTo(titleLabel);
//            }];
//            jifenLabel.text = @"256362";
//        }
        else if (i == 4) {
            UILabel *visitorCountLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:visitorCountLabel];
            [visitorCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            self.visitorCountLabel = visitorCountLabel;
//            visitorCountLabel.text = @"256362";
            
            CGFloat imgWidth = 30;
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(35 + imgWidth + MARGIN_10);
            }];
            self.visitorCountView = singleView;
        } else if (i == 5) {
            
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

+ (CGFloat )getHeightWithModel:(UserMainPageModel *)model {
    
    if (model) {
        
        CGFloat marginLeft = 85;
        CGFloat imgWidth = 30;
        CGFloat contentHeight = [model.userInfo.addr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
        CGFloat height2 = MAX(contentHeight, 35);
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
    return 0;
}

- (void)setModel:(UserMainPageModel *)model {
    _model = model;
    
    CGFloat marginLeft = 85;
    
    [self.imageV sd_setImageWithURL:URLWithString(model.userInfo.headUrl) placeholderImage:imageNamed(@"placeholder_image_loadFaile")];
    self.nameLabel.text = model.userInfo.nikeName;
    self.ageLabel.text = [NSString stringWithFormat:@" %@ ",model.userInfo.age];
    self.genderLabel.text = [NSString stringWithFormat:@" %@ ",[model.userInfo.sex integerValue] == 1 ? @"男" : @"女"];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@KM",model.userInfo.distance];
    
    self.addressLabel.text = model.userInfo.addr;
    CGFloat contentHeight = [model.userInfo.addr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
    [self.addressLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MAX(contentHeight, 35));
    }];
    
    for (UIView *view in self.photosView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat imgWidth = 30;
    NSInteger maxCount = floorf((ScreenWidth - marginLeft - MARGIN_15)/(imgWidth + MARGIN_5));
    NSInteger repeat = MIN(maxCount, model.phontList.count);
    for (int i = 0; i < repeat; i++) {
        UserMainPagePhotoListModel *photo = model.phontList[i];
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = imageNamed(@"placeholder_image_loadFaile");
        [imageV sd_setImageWithURL:URLWithString(photo.photosUrl) placeholderImage:imageNamed(@"placeholder_image_loadFaile")];
        [imageV setDefaultCorner];
        [self.photosView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft + i * (imgWidth + MARGIN_5));
            make.top.mas_equalTo((42 - imgWidth)/2.f);
            make.width.mas_equalTo(imgWidth);
            make.height.mas_equalTo(imgWidth);
        }];
    }
    //认证
    [self setAuthImageWithModel:model.userInfo];
    
    //访客量
    self.visitorCountLabel.text =
    for (UIView *view in self.photosView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    self.visitorCountView
    NSInteger count = floorf((SCREEN_WIDTH - marginLeft - MARGIN_15 + MARGIN_5)/(imgWidth + MARGIN_5));
    NSInteger maxRepeat = MIN(count, model.accessList.count);
    for (int i = 0; i < maxRepeat; i++) {
        UserMainPageAccessListModel *accessModel = model.accessList[i];
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = imageNamed(placeHolderHeadImageName);
        [imageV setCorner:imgWidth/2.f];
        [self.visitorCountView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft + i * (imgWidth + MARGIN_5));
            make.top.mas_equalTo(35);
            make.width.mas_equalTo(imgWidth);
            make.height.mas_equalTo(imgWidth);
        }];
    }
    
    
}

#pragma mark - private

- (void)setAuthImageWithModel:(UserMainPageUserInfoModel *)model {
    
    NSMutableArray *authImages = [NSMutableArray array];
    if (model.phone.length > 0) {//手机认证
        [authImages addObject:imageNamed(@"personalAuth_icon_phone")];
    }
    if (model.wxNumber.length > 0) {//微信认证
        [authImages addObject:imageNamed(@"personalAuth_icon_weichat")];
    }
    if (model.isCertification.length == 1) {//身份认证
        [authImages addObject:imageNamed(@"personalAuth_icon_idCard")];
    }
    if (model.aliPayNumber.length > 0) {//支付宝认证
        [authImages addObject:imageNamed(@"personalAuth_icon_alipay")];
    }
    //    if ([model.xxx integerValue] == 1) {//技能认证
    //        [authImages addObject:imageNamed(@"personalAuth_icon_skill")];
    //    }
    
    [self.authLabel setAuthImages:authImages];
}


#pragma mark - getter -

@end
