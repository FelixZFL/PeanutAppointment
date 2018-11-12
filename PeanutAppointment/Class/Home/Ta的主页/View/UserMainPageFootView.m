//
//  UserMainPageFootView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/23.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "UserMainPageFootView.h"

@interface UserMainPageFootView()

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
            contentLabel.text = @"星期 一 二 三 四 五 六 七";
        } else if (i == 1) {
            contentLabel.text = @"客户找我";
        } else if (i == 2) {
            contentLabel.text = @"200.00元/次";
        } else if (i == 3) {
            contentLabel.text = @"100.00元";
        } else if (i == 4) {
            NSString *contentStr = @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件";
            contentLabel.text = contentStr;
            CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(contentHeight);
                }];
            }
        } else if (i == 5) {
            NSString *contentStr = @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件寄过来开发了份";
            contentLabel.text = contentStr;
            CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(contentHeight);
                }];
            }
        } else if (i == 6) {
            NSString *contentStr = @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊防静电卡李经理咖妃了多久奥卡福打飞机奥斯卡了发动机可是对方哈啊撒地方了卡拉山口附件寄过来开发了份";
            contentLabel.text = contentStr;
            CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(contentHeight);
                }];
            }
        }
        lastView = singleView;
    }
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat height = 35 *4 ;
    
    CGFloat marginLeft = 85;
    NSArray *contentArray = @[@"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件",
                              @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊可是对方哈啊撒地方了卡拉山口附件寄过来开发了份",
                              @"老是卡迪克兰啊付款结算单撒大了饭卡上撒 啊防静电卡李经理咖妃了多久奥卡福打飞机奥斯卡了发动机可是对方哈啊撒地方了卡拉山口附件寄过来开发了份"];
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

#pragma mark - getter -

@end
