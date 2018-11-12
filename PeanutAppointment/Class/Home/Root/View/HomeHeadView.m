//
//  HomeHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeHeadView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HomeModel.h"

#define kBtnTag 4358

@interface HomeHeadView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;//循环滚动轮播图

@property (nonatomic, strong) HomeModel *model;

@property (nonatomic, strong) NSArray<HomeSkillBtnModel *> *btnModelArray;

@end


@implementation HomeHeadView

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
    
    self.backgroundColor = COLOR_UI_F0F0F0;
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.bannerView];
        
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HomeHannerHeight);
    }];
    
   

//    NSArray *btnNameArr = @[@"运动健身",@"美术绘画",@"逛街",@"享美食",@"美妆",@"模特",@"玩游戏",@"全部"];
//    NSArray *btnImageArr = @[@"home_top_btn_1",@"home_top_btn_2",@"home_top_btn_3",@"home_top_btn_4",@"home_top_btn_5",@"home_top_btn_6",@"home_top_btn_7",@"home_top_btn_8"];
    
    NSInteger column = 4;
    
    CGFloat btnW = SCREEN_WIDTH/column;
    CGFloat btnH = 110;
    
    CGFloat btnViewHeight = btnH * ceilf(self.btnModelArray.count/(float)column);
    
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = COLOR_UI_FFFFFF;
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.bannerView.mas_bottom);
        make.height.mas_equalTo(btnViewHeight);
    }];
    for (int i = 0; i < self.btnModelArray.count; i++) {
        HomeSkillBtnModel *model = self.btnModelArray[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%column * btnW, i/column * btnH, btnW, btnH)];
        [btn setTitle:model.pasName forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        [btn setImage:imageNamed(model.btnImage) forState:UIControlStateNormal];
        [btn setImage:imageNamed(model.btnImage) forState:UIControlStateHighlighted];
        btn.titleLabel.font = KFont(12);
        btn.backgroundColor = COLOR_UI_FFFFFF;
        [btn addTarget:self action:@selector(headBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBtnTag + i;
        [btn verticalImageAndTitle:MARGIN_5];
        [btnView addSubview:btn];
    }
    
    [self addSubview:self.activityView];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(btnView.mas_bottom);
        make.height.mas_equalTo([HomeActivityView getHeight]);
    }];
    
    [self addSubview:self.starView];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.activityView.mas_bottom);
        make.height.mas_equalTo([HomeStarOfTodayView getHeight]);
    }];
    
    [self addSubview:self.talentView];
    [self.talentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(weakSelf.starView.mas_bottom);
        make.height.mas_equalTo([HomeGotTalentView getHeight]);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return HomeHannerHeight + 110*2 + [HomeActivityView getHeight] + [HomeStarOfTodayView getHeight] + [HomeGotTalentView getHeight];
}

- (void)updateWithModel:(HomeModel *)model {
    _model = model;
    //设置banner图
    NSMutableArray *picArr = [NSMutableArray arrayWithCapacity:1];
    for (HomeBannerModel *banner in model.banner) {
        NSString *photo = [NSString stringWithFormat:@"%@",banner.photoUrl];
        [picArr addObject:photo];
    }
    self.bannerView.imageURLStringsGroup = picArr;
    
    if (model.gamePhotos.count >=3) {
        HomeGamesModel *game1 = model.gamePhotos[0];
        HomeGamesModel *game2 = model.gamePhotos[1];
        HomeGamesModel *game3 = model.gamePhotos[2];
        
        [self.activityView.image1 sd_setImageWithURL:URLWithString(game1.photoUrl)];
        [self.activityView.image2 sd_setImageWithURL:URLWithString(game2.photoUrl)];
        [self.activityView.image3 sd_setImageWithURL:URLWithString(game3.photoUrl)];
    }
    
    for (int i = 0; i < self.starView.photoViewArray.count; i++) {
        UIImageView *imageV = self.starView.photoViewArray[i];
        if (model.toDayHotUser.count > i) {
            imageV.hidden = NO;
            HomeHotUserModel *hotUser = model.toDayHotUser[i];
            [imageV sd_setImageWithURL:URLWithString(hotUser.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        }else {
            imageV.hidden = YES;
        }
    }
    
    for (int i = 0; i < self.talentView.photoViewArray.count; i++) {
        UIImageView *imageV = self.talentView.photoViewArray[i];
        if (model.toDayHotUser.count > i) {
            imageV.hidden = NO;
            HomeVideoHotUserModel *hotUser = model.toDayVideoHotUser[i];
            [imageV sd_setImageWithURL:URLWithString(hotUser.voidUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        }else {
            imageV.hidden = YES;
        }
    }
    
    self.talentView.noticeView.contentLabel.text = model.notice;
    
}

#pragma mark - action -

- (void)headBtnAction:(UIButton *)btn {
    if (self.btnModelArray.count > btn.tag - kBtnTag && self.headButtonBlock) {
        self.headButtonBlock(self.btnModelArray[btn.tag - kBtnTag]);
    }
}

#pragma mark - SDCycleScrollViewDelegate -

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.model.banner.count > index) {
        HomeBannerModel *banner = self.model.banner[index];
        NSLog(@"图片地址 ===   %@",banner.clickUrl);
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    //    NSLog(@"图片滚动回调");
}


#pragma mark - getter -

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[SDCycleScrollView alloc] init];
        _bannerView.delegate  = self;
        _bannerView.autoScrollTimeInterval = 5;
        _bannerView.currentPageDotColor = COLOR_UI_THEME_RED;
        _bannerView.pageDotColor = COLOR_UI_FFFFFF;
        _bannerView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    }
    return _bannerView;
}

- (HomeActivityView *)activityView {
    if (!_activityView) {
        _activityView = [[HomeActivityView alloc] init];
    }
    return _activityView;
}


- (HomeStarOfTodayView *)starView {
    if (!_starView) {
        _starView = [[HomeStarOfTodayView alloc] init];
    }
    return _starView;
}


- (HomeGotTalentView *)talentView {
    if (!_talentView) {
        _talentView = [[HomeGotTalentView alloc] init];
    }
    return _talentView;
}

- (NSArray<HomeSkillBtnModel *> *)btnModelArray {
    if (!_btnModelArray) {
        NSArray *array = @[@{@"pasId":@"91",@"pasName":@"运动健身",@"btnImage":@"home_top_btn_1"},
                           @{@"pasId":@"107",@"pasName":@"美术绘画",@"btnImage":@"home_top_btn_2"},
                           @{@"pasId":@"20",@"pasName":@"逛街",@"btnImage":@"home_top_btn_3"},
                           @{@"pasId":@"8",@"pasName":@"享美食",@"btnImage":@"home_top_btn_4"},
                           @{@"pasId":@"38",@"pasName":@"美妆",@"btnImage":@"home_top_btn_5"},
                           @{@"pasId":@"45",@"pasName":@"模特",@"btnImage":@"home_top_btn_6"},
                           @{@"pasId":@"19",@"pasName":@"玩游戏",@"btnImage":@"home_top_btn_7"},
                           @{@"pasId":@"",@"pasName":@"全部",@"btnImage":@"home_top_btn_8"}];
        _btnModelArray = [HomeSkillBtnModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _btnModelArray;
}

@end
