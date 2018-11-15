//
//  UserMainPageFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserMainPageFootView.h"

#import "UserMainPageModel.h"

@interface UserMainPageFootView()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *depositLabel;//定金
@property (nonatomic, strong) UILabel *skillIntroduceLabel;//技能介绍
@property (nonatomic, strong) UILabel *serverIntroduceLabel;//服务介绍
@property (nonatomic, strong) UILabel *workExprenceLabel;//工作经历

@end

@implementation UserMainPageFootView

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

    CGFloat marginLeft = 85;
    
    NSArray *titleArray = @[@"服务时间",@"服务方式",@"服务价格",@"服务订金",@"技能介绍",@"服务介绍",@"工作经历"];
    UIView *lastView = nil;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(0) : make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(35);
        }];
        
        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [singleView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        titleLabel.numberOfLines = 0;
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
            make.width.mas_equalTo(60);
        }];
        [titleLabel changeAligmentRightAndLeftWithWidth:60];
        
        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        [singleView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(marginLeft);
            make.right.mas_equalTo(-MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
        }];
        
        if (i == 0) {
            //contentLabel.text = @"星期 一 二 三 四 五 六 七";
            self.timeLabel = contentLabel;
        } else if (i == 1) {
            //contentLabel.text = @"客户找我";
            self.typeLabel = contentLabel;
        } else if (i == 2) {
            //contentLabel.text = @"200.00元/次";
            self.priceLabel = contentLabel;
        } else if (i == 3) {
            //contentLabel.text = @"100.00元";
            self.depositLabel = contentLabel;
        } else if (i == 4) {
            self.skillIntroduceLabel = contentLabel;
        } else if (i == 5) {
            self.serverIntroduceLabel = contentLabel;
        } else if (i == 6) {
            self.workExprenceLabel = contentLabel;
        }
        lastView = singleView;
    }
}

#pragma mark - public -

+ (CGFloat)getHeightWithModel:(UserMainPageSkillInfoModel *)model {
    
    if (model) {
        CGFloat height = 35 *4 ;
        
        CGFloat marginLeft = 85;
        NSArray *contentArray = @[model.introduce,
                                  model.selfIntroduction,
                                  model.experience];
        for (int i = 0; i < contentArray.count; i++) {
            CGFloat contentHeight = [contentArray[i] getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                height += contentHeight;
            } else {
                height += 35;
            }
        }
        return  height;
    }
    return 0;
    
}

- (void)setModel:(UserMainPageSkillInfoModel *)model {
    _model = model;
    
    if (model) {
        
        NSString *timeString = @"星期 ";
        NSArray *timeArr = [model.serviceTime componentsSeparatedByString:@","];
        for (NSString *time in timeArr) {
            if ([time isEqualToString:@"1"]) {
                timeString = [timeString stringByAppendingString:@"一 "];
            } else if ([time isEqualToString:@"2"]) {
                timeString = [timeString stringByAppendingString:@"二 "];
            } else if ([time isEqualToString:@"3"]) {
                timeString = [timeString stringByAppendingString:@"三 "];
            } else if ([time isEqualToString:@"4"]) {
                timeString = [timeString stringByAppendingString:@"四 "];
            } else if ([time isEqualToString:@"5"]) {
                timeString = [timeString stringByAppendingString:@"五 "];
            } else if ([time isEqualToString:@"6"]) {
                timeString = [timeString stringByAppendingString:@"六 "];
            } else if ([time isEqualToString:@"7"]) {
                timeString = [timeString stringByAppendingString:@"日 "];
            }
        }
        self.timeLabel.text = timeString;
        
        //1:Ta找我 2:我找Ta 3:两个都选  客户找我
        if ([model.serviceType integerValue] == 1) {
            self.typeLabel.text = @"客户找我";
        } else if ([model.serviceType integerValue] == 2) {
            self.typeLabel.text = @"我找客户";
        } else if ([model.serviceType integerValue] == 3) {
            self.typeLabel.text = @"客户找我 / 我找客户";
        }
        self.priceLabel.text = model.servicePrice;

        CGFloat marginLeft = 85;
        
        if (model.introduce) {//技能介绍
            self.skillIntroduceLabel.text = model.introduce;
            CGFloat contentHeight = [model.introduce getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            [self.skillIntroduceLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(MAX(contentHeight, 35));
            }];
        } else if (model.selfIntroduction) {//服务介绍
            self.serverIntroduceLabel.text = model.selfIntroduction;
            CGFloat contentHeight = [model.selfIntroduction getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            [self.serverIntroduceLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(MAX(contentHeight, 35));
            }];
        } else if (model.experience) {//工作经历 服务经历        self.depositLabel.text = model.downPayment;

            self.workExprenceLabel.text = model.experience;
            CGFloat contentHeight = [model.experience getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            [self.workExprenceLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(MAX(contentHeight, 35));
            }];
        }
    }
    
}

#pragma mark - getter -

@end
