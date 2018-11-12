//
//  MyPeanutsHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyPeanutsHeadView.h"

#import "MyPeanutsListModel.h"

#define SingleViewHeight 50.f

@interface MyPeanutsHeadView()

///花生米数量
@property (nonatomic, strong) UILabel *personAuthCountLabel;
///发布技能人数
@property (nonatomic, strong) UILabel *skillAuthCountLabel;

@end

@implementation MyPeanutsHeadView

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
    
    for (int i = 0; i < 2; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i * SingleViewHeight);
            make.height.mas_equalTo(SingleViewHeight);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [singleView addSubview:imageV];

        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        [singleView addSubview:contentLabel];
        
        UILabel *countLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentRight];
        [singleView addSubview:countLabel];
        
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.centerY.equalTo(singleView);
        }];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).with.mas_offset(MARGIN_10);
            make.centerY.equalTo(singleView);
        }];
        
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-MARGIN_15);
            make.centerY.equalTo(singleView);
        }];
        
        if (i == 0) {
            imageV.image = imageNamed(@"myPeanuts_auth_person_big");
            contentLabel.text = @"花生米";
            countLabel.text = @"0人";
            self.personAuthCountLabel = countLabel;
        } else {
            imageV.image = imageNamed(@"myPeanuts_auth_skill_big");
            contentLabel.text = @"发布技能";
            countLabel.text = @"0人";
            self.skillAuthCountLabel = countLabel;
        }
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(MARGIN_10);
    }];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return SingleViewHeight * 2 + MARGIN_10;
}

- (void)updateWithModel:(MyPeanutsListModel *)model {
    self.personAuthCountLabel.text = [NSString stringWithFormat:@"%@人",model.fansSum];
    self.skillAuthCountLabel.text = [NSString stringWithFormat:@"%@人",model.skillsNumber];
}

#pragma mark - action -

#pragma mark - getter -

@end
