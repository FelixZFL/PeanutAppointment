//
//  HomeGotTalentView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeGotTalentView.h"
#import "HomeTitleView.h"

#import "HomeModel.h"

#define kImageTag 4524

@interface HomeGotTalentView()

//@property (nonatomic, strong) NSMutableArray *photoViewArray;

@end

@implementation HomeGotTalentView


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
    [titleView setChiniseTitle:@"今日达人" englishTitle:@"Today's Man"];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(titleHeight);
    }];
    
}

#pragma mark - public -

+ (CGFloat )getHeightWithArray:(NSArray *)array {
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    return [HomeTitleView getHeight] + (photoWidth + MARGIN_1) * ((array.count - 1) + 1) + MARGIN_15;
}

- (void)setDataArray:(NSArray<HomeVideoHotUserModel *> *)dataArray {
    _dataArray = dataArray;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat titleHeight = [HomeTitleView getHeight];
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    for (int i = 0; i < dataArray.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_15 + i%3 * (photoWidth + MARGIN_1), titleHeight + i/3 * (photoWidth + MARGIN_1), photoWidth, photoWidth)];
        imageV.image = imageNamed(@"placeholder_image_loadFaile");
        imageV.tag = kImageTag + i;
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)]];
        [self addSubview:imageV];
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
