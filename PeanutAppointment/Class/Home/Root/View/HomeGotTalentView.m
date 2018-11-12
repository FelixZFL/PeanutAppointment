//
//  HomeGotTalentView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeGotTalentView.h"
#import "HomeTitleView.h"

@interface HomeGotTalentView()


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
    
    
    CGFloat photoWidth = (SCREEN_WIDTH - MARGIN_15 * 2 - MARGIN_1 * 2)/3.f;
    _photoViewArray = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < 6; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_15 + i%3 * (photoWidth + MARGIN_1), titleHeight + i/3 * (photoWidth + MARGIN_1), photoWidth, photoWidth)];
        imageV.image = imageNamed(@"");
        imageV.backgroundColor = COLOR_UI_000000;
        [self addSubview:imageV];
       [_photoViewArray addObject:imageV];
    }
    
    HomeNoticeView *noticeView = [[HomeNoticeView alloc] init];
    [self addSubview:noticeView];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-MARGIN_10);
        make.height.mas_equalTo([HomeNoticeView getHeight]);
    }];
    self.noticeView = noticeView;
    
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

    return [HomeTitleView getHeight] + photoWidth*2 + MARGIN_1 + MARGIN_15 + [HomeNoticeView getHeight] + MARGIN_10;
}

#pragma mark - getter -


@end
