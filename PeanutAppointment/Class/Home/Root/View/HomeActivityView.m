//
//  HomeActivityView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeActivityView.h"
#import "HomeModel.h"

#define kImageTag 500

@interface HomeActivityView()

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;

@end

@implementation HomeActivityView

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
    
    for (int i = 0 ; i < 3; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = imageNamed(@"placeholder_image_loadFaile");
        imageV.tag = kImageTag + i;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)]];
        [self addSubview:imageV];
        
        if (i == 0) {
            self.image1 = imageV;
        } else if (i == 1) {
            self.image2 = imageV;
        } else {
            self.image3 = imageV;
        }
    }
    
    __weak __typeof(self)weakSelf = self;
    
    CGFloat imageVHeight = ((SCREEN_WIDTH - 30) * 200/345.f)/2.f;

    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.height.mas_equalTo(imageVHeight * 2);
    }];
    
    CGFloat imageVWidth = (SCREEN_WIDTH - 30 - MARGIN_1)/2.f;
    
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.equalTo(weakSelf.image1.mas_bottom).with.mas_offset(MARGIN_1);
        make.width.mas_equalTo(imageVWidth);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    [_image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.image1.mas_bottom).with.mas_offset(MARGIN_1);
        make.width.mas_equalTo(imageVWidth);
        make.height.mas_equalTo(imageVHeight);
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
    
    
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat imageVHeight = ((SCREEN_WIDTH - 30) * 200/345.f)/2.f;
    return imageVHeight * 3 + MARGIN_1 + MARGIN_10 + MARGIN_10;
}

- (void)setGamesArray:(NSArray<HomeGamesModel *> *)gamesArray {
    _gamesArray = gamesArray;
    
    for (int i = 0; i < gamesArray.count; i++) {
        HomeGamesModel *model = gamesArray[i];
        if (i == 0) {
            [self.image1 sd_setImageWithURL:URLWithString(model.photoUrl)];
        } else if (i == 1) {
            [self.image2 sd_setImageWithURL:URLWithString(model.photoUrl)];
        } else if (i == 2) {
            [self.image3 sd_setImageWithURL:URLWithString(model.photoUrl)];
        }
    }
}

#pragma mark - action -

- (void)imageClickAction:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - kImageTag;
    if (self.imageTapAction && self.gamesArray.count > index) {
        self.imageTapAction(index, self.gamesArray[index]);
    }
}


#pragma mark - getter -


@end
