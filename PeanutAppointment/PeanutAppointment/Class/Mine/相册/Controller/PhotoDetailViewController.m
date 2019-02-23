//
//  PhotoDetailViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/11/27.
//  Copyright © 2018 felix. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

#import "PhotoAlbumPhotosModel.h"

@interface PhotoDetailViewController ()<SDCycleScrollViewDelegate>

@end

@implementation PhotoDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] init];
    bannerView.delegate  = self;
    bannerView.autoScroll = NO;
    bannerView.currentPageDotColor = COLOR_UI_THEME_RED;
    bannerView.pageDotColor = COLOR_UI_FFFFFF;
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    
    NSArray *arr = [_photoModel.photosUrl componentsSeparatedByString:@","];
    bannerView.imageURLStringsGroup = arr;
    if (arr.count > _selectIndex) {
        [bannerView makeScrollViewScrollToIndex:_selectIndex];
    }
    
    
}

- (void)setupNav {
    [self.customNavBar setLeftButtonWithImage:imageNamed(@"main_nav_close")];
    [self.view bringSubviewToFront:self.customNavBar];
    [self.customNavBar setBackgroundAlpha:0];
}


#pragma mark - network


#pragma mark - action


#pragma mark - SDCycleScrollViewDelegate -
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    //    NSLog(@"图片滚动回调");
}


@end
