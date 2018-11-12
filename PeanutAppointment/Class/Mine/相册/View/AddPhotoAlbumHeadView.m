//
//  AddPhotoAlbumHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddPhotoAlbumHeadView.h"

#import "PhotoTypeListModel.h"

@interface AddPhotoAlbumHeadView()

@end

@implementation AddPhotoAlbumHeadView

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
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_10);
        make.width.mas_equalTo(60);
    }];
    titleLabel.text = @"类型";
    [titleLabel changeAligmentRightAndLeftWithWidth:60];
    
    self.tagView = [[ChooseTagView alloc] initWithFrame:CGRectMake(MARGIN_15 + 60 + MARGIN_15, 0, SCREEN_WIDTH - 60 - MARGIN_15 * 3, 0) tagArray:[NSMutableArray array] textColorSelected:COLOR_UI_FFFFFF textColorNormal:COLOR_UI_666666 backgroundColorSelected:COLOR_UI_THEME_RED backgroundColorNormal:COLOR_UI_FFFFFF];
    [self addSubview:self.tagView];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

#pragma mark - public -

- (void)setTagArray:(NSArray *)tagArray {
    _tagArray = tagArray;
    
    self.tagView.frame = CGRectMake(MARGIN_15 + 60 + MARGIN_15, 0, SCREEN_WIDTH - 60 - MARGIN_15 * 3, [ChooseTagView getHeightWithTagArray:tagArray maxWidth:SCREEN_WIDTH - 60 - MARGIN_15 * 3]);
    [self.tagView setTagArray:tagArray];
    
}

+ (CGFloat )getHeightwithArray:(NSArray *)array {

    return MAX(35, [ChooseTagView getHeightWithTagArray:array maxWidth:SCREEN_WIDTH - 60 - MARGIN_15 * 3]);
}

#pragma mark - action -

#pragma mark - getter -



@end
