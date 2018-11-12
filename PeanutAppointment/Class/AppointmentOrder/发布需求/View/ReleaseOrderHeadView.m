//
//  ReleaseOrderHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ReleaseOrderHeadView.h"
#import "ReleaseOrderUserModel.h"

#define kBtnTag 8474

@interface ReleaseOrderHeadView()

@property (nonatomic, strong) UILabel *skillNameLabel;

@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@end

@implementation ReleaseOrderHeadView

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
    
    UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"技能分类";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(60);
    }];
    
    UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(titleLabel);
    }];
    self.skillNameLabel = contentLabel;
    
    CGFloat imgHeight = SCREEN_WIDTH - MARGIN_15 * 2;
    
    UIView *contentBgView = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [contentBgView setDefaultCorner];
    [self addSubview:contentBgView];
    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(titleLabel.mas_bottom);
        make.height.mas_equalTo(imgHeight + 40);
    }];
    
    UIImageView *headImgV = [[UIImageView alloc] init];
    headImgV.backgroundColor = COLOR_UI_000000;
    [contentBgView addSubview:headImgV];
    [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(imgHeight);
    }];
    self.headImgV = headImgV;
    
    CGFloat btnWidth = 70;
    CGFloat btnMarginX = (imgHeight - btnWidth * 2)/3;
    for (int i = 0; i < 2 ; i++) {
        UIButton *btn = [[UIButton alloc] init];
        NSString *imageName = i == 0 ? @"ReleaseOrder_btn_dislike" : @"ReleaseOrder_btn_like";
        [btn setButtonStateNormalImage:imageNamed(imageName)];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentBgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnMarginX + i * (btnWidth + btnMarginX));
            make.width.height.mas_equalTo(btnWidth);
            make.centerY.equalTo(headImgV);
        }];
    }    
    
    
    UILabel *nameLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    [contentBgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    self.nameLabel = nameLabel;
    //nameLabel.text = @"笑笑";
    
    UILabel *ageLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
    ageLabel.backgroundColor = COLOR_UI_THEME_RED;
    [ageLabel setDefaultCorner];
    [contentBgView addSubview:ageLabel];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(nameLabel);
    }];
    self.ageLabel = ageLabel;
    //ageLabel.text = @" 23岁 ";
    
    UILabel *genderLabel = [UILabel labelWithFont:KFont(10) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentCenter];
    genderLabel.backgroundColor = COLOR_UI_THEME_RED;
    [genderLabel setDefaultCorner];
    [contentBgView addSubview:genderLabel];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ageLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(ageLabel);
    }];
    self.genderLabel = genderLabel;
    //genderLabel.text = @" 女 ";
    
    UILabel *distanceLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
    [contentBgView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.centerY.equalTo(nameLabel);
    }];
    self.distanceLabel = distanceLabel;
    //distanceLabel.text = @"10KM";
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat imgHeight = SCREEN_WIDTH - MARGIN_15 * 2;
    return  45 + imgHeight + 40 + MARGIN_15;
}

- (void)setModel:(ReleaseOrderUserModel *)model {
    _model = model;
    if (model) {
        self.hidden = NO;
        
        [self.headImgV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        self.nameLabel.text = model.nikeName;
        self.ageLabel.text = [NSString stringWithFormat:@" %@ ",model.age];
        self.genderLabel.text = [model.sex integerValue] == 1 ? @" 男 " : @" 女 ";
        self.distanceLabel.text = [NSString stringWithFormat:@"%@KM",model.distance];
        
    } else {
        self.hidden = YES;
    }
}

- (void)btnClickAction:(UIButton *)sender {
    if (self.chooseBlock && _model) {
        self.chooseBlock(sender.tag - kBtnTag == 1 , _model);
    }
}

#pragma mark - getter -



@end
