//
//  HomeCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeCell.h"
#import "UserBaseInfoView.h"

#import "HomeIndexUserModel.h"

#define kBtnTag 235
#define kImageTag 5636


@interface HomeCell()

@property (nonatomic, strong) UserBaseInfoView *userView;

@property (nonatomic, strong) UIView *photoView;

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *rewardButton;
@property (nonatomic, strong) UIButton *appointmentButton;


@end

@implementation HomeCell

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
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo([UserBaseInfoView getHeight]);
    }];
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    
    UIView *photoView = [[UIView alloc] init];
    [self addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.userView.mas_bottom);
        make.height.mas_equalTo(photoWidth);
    }];
    self.photoView = photoView;
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_15 + i * (photoWidth + MARGIN_1), 0, photoWidth, photoWidth)];
        imageV.image = imageNamed(@"placeholder_image_loadFaile");
        imageV.tag = kImageTag + i;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)]];
        [photoView addSubview:imageV];
    }
    
    CGFloat btnHeight = 44;
    CGFloat btnWidht = SCREEN_WIDTH/5.f;
    
    UIView *btnView = [[UIView alloc] init];
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(photoView.mas_bottom);
        make.height.mas_equalTo(btnHeight);
    }];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * btnWidht, 0, btnWidht, btnHeight)];
        [btn setButtonStateNormalTitle:@"" Font:KFont(12) textColor:COLOR_UI_666666];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        if (i == 0) {
            [btn setImage:imageNamed(@"home_btn_share") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"分享"];
            self.shareButton = btn;
        }else if (i == 1) {
            [btn setImage:imageNamed(@"home_btn_comment") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"0"];
            self.commentButton = btn;
        }else if (i == 2) {
            [btn setImage:imageNamed(@"home_btn_like") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"0"];
            self.likeButton = btn;
        }else if (i == 3) {
            [btn setImage:imageNamed(@"home_btn_reward") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"0"];
            self.rewardButton = btn;
        }else {
            [btn setImage:imageNamed(@"home_btn_appointment") forState:UIControlStateNormal];
            [btn setButtonStateNormalTitle:@"约Ta"];
            self.appointmentButton = btn;
        }
        
    }
    
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MARGIN_10);
    }];
    
}

#pragma mark - public -

- (void)setModel:(HomeIndexUserModel *)model {
    _model = model;
    [self.userView.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.userView.typeLevelLabel.text = @"";
    self.userView.distanceLabel.text = [NSString stringWithFormat:@"%.2fKM",[model.distance integerValue]/1000.f];
    self.userView.nickNameLabel.text = model.nikeName;
    self.userView.ageLabel.text = model.age;
    self.userView.genderLabel.text = [model.sex integerValue] == 1 ? @"男" : @"女";
    [self setAuthImageWithModel:model];
    
    for (int i = 0; i < self.photoView.subviews.count; i++) {
        UIImageView *imageV = self.photoView.subviews[i];
        NSArray *photoArray = [model.photos componentsSeparatedByString:@","];
        if (photoArray.count > i) {
            [imageV sd_setImageWithURL:URLWithString(photoArray[i]) placeholderImage:imageNamed(@"placeholder_image_loadFaile")];
        } else {
            imageV.image = imageNamed(@"placeholder_image_loadFaile");
        }
    }
    
    [self.commentButton setButtonStateNormalTitle:model.commentNumber];
    [self.likeButton setButtonStateNormalTitle:model.likeNumber];
    [self.rewardButton setButtonStateNormalTitle:model.goldNumber];
    
}

- (void)setAuthImageWithModel:(HomeIndexUserModel *)model {
    
    NSMutableArray *authImages = [NSMutableArray array];
    if (model.phone.length > 0) {//手机认证
        [authImages addObject:imageNamed(@"personalAuth_icon_phone")];
    }
    if (model.wxNumber.length > 0) {//微信认证
        [authImages addObject:imageNamed(@"personalAuth_icon_weichat")];
    }
    if (model.cardNumber.length > 1) {//身份认证
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


+ (CGFloat)getCellHeight {
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    return [UserBaseInfoView getHeight] + photoWidth + 44 + MARGIN_10;
}

#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    if (self.btnClickBlock && self.model) {
        self.btnClickBlock(sender.tag - kBtnTag, self.model, sender);
    }
}

- (void)userinfoTapAction {
    if (self.userInfoBlock && self.model) {
        self.userInfoBlock(self.model);
    }
}

- (void)imageClickAction:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - kImageTag;
    if (self.imageClickBlock && self.model) {
        self.imageClickBlock(index, self.model);
    }
}
#pragma mark - getter -

- (UserBaseInfoView *)userView {
    if (!_userView) {
        _userView = [[UserBaseInfoView alloc] init];
        [_userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userinfoTapAction)]];
    }
    return _userView;
}


@end
