//
//  HomeFiltrateAlertView.m
//  PeanutAppointment
//
//  Created by felix on 2018/11/14.
//  Copyright © 2018 felix. All rights reserved.
//

#import "HomeFiltrateAlertView.h"

@interface HomeFiltrateAlertView()

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIImage *image;

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
    
    NSArray *btnArr = @[@"QQ",@"微信",@"朋友圈"];
    NSArray *btnImageArr = @[@"share_btn_qq",@"share_btn_weichat",@"share_btn_friend"];
    
    CGFloat btnWidth = SCREEN_WIDTH/btnArr.count;
    
    for (int i = 0; i < btnArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, KbtnHeight)];
        [btn setButtonStateNormalTitle:btnArr[i] Font:KFont(12) textColor:COLOR_UI_666666];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateNormal];
        [btn setImage:imageNamed(btnImageArr[i]) forState:UIControlStateHighlighted];
        [btn verticalImageAndTitle:MARGIN_5];
        btn.tag = kBtnTag + i;
        [btn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [self downloadImageToShare:nil];
    
    
    [window addSubview:self];
    self.y = window.height - KbtnHeight - HOMEBAR_HEIGHT;
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithModel:(ShareDataModel *)model {
    AlertShareView *alert = [[AlertShareView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KbtnHeight)];
    alert.model = model;
    return alert;
}

#pragma mark - action -

- (void)downloadImageToShare:(UIButton *)sender {
    // 利用 SDWebImage 框架提供的功能下载图片
    NSString *url = self.model.headUrl;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        // do nothing
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES completion:^{
            
            NSData *fileData = [PATool compressOriginalImage:image toMaxDataSizeKBytes:32];
            NSLog(@"fileData---length ---%ld",fileData.length);
            
            UIImage *image = [UIImage imageWithData:fileData];
            
            while (fileData.length > 32 * 1000) {
                UIImage *newImage = [image resizeTo:CGSizeMake(image.size.width * 0.5, image.size.width * 0.5)];
                
                fileData = [PATool compressOriginalImage:newImage toMaxDataSizeKBytes:32];
                NSLog(@"fileData---length ---%ld",fileData.length);
                image = [[UIImage imageWithData:fileData] resizeTo:CGSizeMake(image.size.width * 0.5, image.size.width * 0.5)];
                self.image = image;
            }
            
            self.image = image;
            if (sender) {
                [self shareBtnAction:sender];
            }
        }];
    }];
}

- (void)shareBtnAction:(UIButton *)sender {
    
    
    [self removFromWindow];
}

@end
