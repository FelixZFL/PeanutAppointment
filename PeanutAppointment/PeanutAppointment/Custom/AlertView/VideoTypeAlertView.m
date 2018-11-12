//
//  VideoTypeAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/13.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "VideoTypeAlertView.h"

#define KbtnHeight 150.f

#define KalertHeight (150.f * 1)

#define kBtnTag 957

@interface VideoTypeAlertView()

@property (nonatomic, copy) BtnClcikBlock btnBlock;

@property (nonatomic, strong) UIView *layerView;

@end

@implementation VideoTypeAlertView

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
    
//    NSArray *btnArr = @[@"视频拍摄",@"视频编辑",@"视频剪辑",@"魔法相机",@"互动直播"];
//    NSArray *btnImageArr = @[@"video_alert_1",@"video_alert_2",@"video_alert_3",@"video_alert_4",@"video_alert_5"];
    NSArray *btnArr = @[@"视频拍摄",@"互动直播"];
    NSArray *btnImageArr = @[@"video_alert_1",@"video_alert_5"];
    CGFloat btnWidth = SCREEN_WIDTH/2;
    
    for (int i = 0; i < btnArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i%2 *btnWidth, i/2 * KbtnHeight , btnWidth, KbtnHeight)];
        [btn setButtonStateNormalTitle:btnArr[i] Font:KFont(12) textColor:COLOR_UI_666666];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateHighlighted];
        [btn verticalImageAndTitle:MARGIN_5];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
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
    self.y = window.height - KalertHeight - HOMEBAR_HEIGHT;
}

- (void)removFromWindow {
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}
+ (instancetype )alertWithBlock:(BtnClcikBlock )block {
    VideoTypeAlertView *alert = [[VideoTypeAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KalertHeight)];
    alert.btnBlock = block;
    return alert;
}

#pragma mark - action -

- (void)btnAction:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock(sender.tag - kBtnTag);
    }
    [self removFromWindow];
}

#pragma mark - getter

@end
