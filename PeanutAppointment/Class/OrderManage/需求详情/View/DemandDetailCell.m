//
//  DemandDetailCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "DemandDetailCell.h"
#import "UserBaseInfoView.h"

@interface DemandDetailCell()

@property (nonatomic, strong) UserBaseInfoView *userView;

@end

@implementation DemandDetailCell

#pragma mark - lifeCycle -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_F0F0F0;
    
    __weak __typeof(self)weakSelf = self;
    
    UIView *whiteBgView = [UIView viewWithColor:COLOR_UI_FFFFFF];
    [self addSubview:whiteBgView];
    [whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-MARGIN_10);
    }];
    
    CGFloat userHeight = [UserBaseInfoView getHeight];
    
    [whiteBgView addSubview:self.userView];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(userHeight);
    }];
    
    UIView *line = [UIView viewWithColor:COLOR_UI_F0F0F0];
    [whiteBgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.bottom.equalTo(weakSelf.userView.mas_bottom);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    CGFloat marginLeft = 85;

    NSArray *titleArray = @[@"线下服务",@"Ta的优势",@"应邀时间"];
    UIView *lastView = nil;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [whiteBgView addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(userHeight) : make.top.equalTo(lastView.mas_bottom);
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
            contentLabel.text = @"256.00元/小时";
        } else if (i == 1) {
            NSString *contentStr = @"路边数据库里的发送旅客阿斯顿发卡看 得见啊发哈是大力开发和撒地方了看见 发来看哈是阿斯顿联发科技啊号是";
            contentLabel.text = contentStr;
            CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 * 3 font:KFont(14)] + MARGIN_10 * 2;
            if (contentHeight > 35 ) {
                [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(contentHeight);
                }];
            }
        } else if (i == 2) {
            contentLabel.text = @"2018-08-31 05:25:25";
        }
        lastView = singleView;
    }
    
    
    NSArray *btnArray = @[@"去评价",@"付余款",@"申请退款",@"发消息"];
    CGFloat btnWith = 66;
    CGFloat btnHeight = 30;
    CGFloat marginX = (SCREEN_WIDTH - MARGIN_15 * 2 - btnWith * btnArray.count)/(btnArray.count + 1);
    
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 + i * (btnWith + marginX), MARGIN_5, btnWith, btnHeight)];
        btn.titleLabel.font = KFont(14);
        [btn setDefaultCorner];
        [btn setborderColor:COLOR_UI_THEME_RED];
        [btn setButtonStateNormalTitle:btnArray[i]];
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [whiteBgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-marginX - i * (btnWith + marginX));
            make.bottom.mas_equalTo(-MARGIN_15);
            make.width.mas_equalTo(btnWith);
            make.height.mas_equalTo(btnHeight);
        }];
        if (i == 0) {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
        } else if (i == 1) {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
        } else if (i == 2) {
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
        } else if (i == 3) {
            btn.backgroundColor = COLOR_UI_THEME_RED;
            [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
        }
    }
    self.bottomLine.hidden = YES;
}

#pragma mark - public -
//- (void)setModel:(MyExceptionalModel * _Nonnull)model index:(NSInteger )index {
//    _model = model;
//
//    self.numLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
//}

+ (CGFloat)getCellHeight {
    CGFloat marginLeft = 85;
    NSString *contentStr = @"路边数据库里的发送旅客阿斯顿发卡看 得见啊发哈是大力开发和撒地方了看见 发来看哈是阿斯顿联发科技啊号是";
    CGFloat contentHeight = [contentStr getHeightWithMaxWidth:SCREEN_WIDTH - marginLeft - MARGIN_15 * 3 font:KFont(14)] + MARGIN_10 * 2;
    return [UserBaseInfoView getHeight] + 35 * 2 + contentHeight + MARGIN_15 * 2 + 30 + MARGIN_10;
}

#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    
}

#pragma mark - getter -

- (UserBaseInfoView *)userView {
    if (!_userView) {
        _userView = [[UserBaseInfoView alloc] init];
        _userView.distanceLabel.hidden = YES;
    }
    return _userView;
}

@end
