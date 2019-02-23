//
//  HomeStarOfTodayView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeStarOfTodayView.h"
#import "HomeTitleView.h"

#import "HomeModel.h"

#define kImageTag 4524

@interface HomeStarOfTodayView()

//@property (nonatomic, strong) NSMutableArray *photoViewArray;

@property (nonatomic, strong) UIImageView *photo1;
@property (nonatomic, strong) UIImageView *photo2;
@property (nonatomic, strong) UIImageView *photo3;

@end

@implementation HomeStarOfTodayView

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
    
    CGFloat titleHeight = [HomeTitleView getHeight];
    
    HomeTitleView *titleView = [[HomeTitleView alloc] init];
    [titleView setChiniseTitle:@"今日之星" englishTitle:@"Star Of Today"];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(titleHeight);
    }];
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_15 + i * (photoWidth + MARGIN_1), titleHeight, photoWidth, photoWidth)];
        [imageV setCorner:photoWidth/2.f];
        imageV.image = imageNamed(placeHolderHeadImageName);
        imageV.tag = kImageTag + i;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)]];
        [self addSubview:imageV];
        if (i == 0) {
            self.photo1 = imageV;
        }else if (i == 1) {
            self.photo2 = imageV;
        }else {
            self.photo3 = imageV;
        }
    }
    
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
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    return [HomeTitleView getHeight] + photoWidth + MARGIN_10 + MARGIN_10;
}

- (void)setDataArray:(NSArray<HomeHotUserModel *> *)dataArray {
    _dataArray = dataArray;
    
    for (int i = 0; i < dataArray.count; i++) {
        HomeHotUserModel *model = dataArray[i];
        if (i == 0) {
            [self.photo1 sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        } else if (i == 1) {
            [self.photo2 sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        } else if (i == 2) {
            [self.photo3 sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        }
    }
}

#pragma mark - action -

- (void)imageClickAction:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - kImageTag;
    if (self.tapActionBlcok && self.dataArray.count > index) {
        self.tapActionBlcok(self.dataArray[index]);
    }
}

#pragma mark - getter -


@end
