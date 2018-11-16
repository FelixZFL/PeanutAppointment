//
//  HomeNoticeView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeNoticeView.h"
#import "LMJScrollTextView2.h"
#import "HomeModel.h"

@interface HomeNoticeView()
//@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) LMJScrollTextView2 *scrollTextView;

@end

@implementation HomeNoticeView

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
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
    UIButton *noticeBtn = [[UIButton alloc] init];
    [noticeBtn setButtonStateNormalTitle:@" 通知" Font:KFont(12) textColor:COLOR_UI_000000];
    [noticeBtn setImage:imageNamed(@"home_icon_notification") forState:UIControlStateNormal];
    [self addSubview:noticeBtn];
    
//    [self addSubview:self.contentLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf);
    }];
    //    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(noticeBtn.mas_right).with.mas_offset(MARGIN_15);
    //        make.centerY.equalTo(weakSelf);
    //    }];
    
    
    _scrollTextView = [[LMJScrollTextView2 alloc] initWithFrame:CGRectMake(70, 0, ScreenWidth - 70, 30)];
    _scrollTextView.textStayTime        = 2;
    _scrollTextView.scrollAnimationTime = 1;
    _scrollTextView.textColor           = COLOR_UI_222222;
    _scrollTextView.textFont            = KFont(12);
    _scrollTextView.textAlignment       = NSTextAlignmentLeft;
    _scrollTextView.touchEnable         = NO;
    [self addSubview:_scrollTextView];
}

#pragma mark - public -

+ (CGFloat)getHeight {
    
    return 30;
}

- (void)setArray:(NSArray<HomeNoticeListModel *> *)array {
    _array = array;
    NSMutableArray *textArr = [NSMutableArray arrayWithCapacity:1];
    for (HomeNoticeListModel *model in array) {
        [textArr addObject:model.nikeName];
    }
    _scrollTextView.textDataArr = textArr;
    [_scrollTextView startScrollBottomToTopWithNoSpace];
}

#pragma mark - getter -

//- (UILabel *)contentLabel {
//    if (!_contentLabel) {
//        _contentLabel = [[UILabel alloc] init];
//        [_contentLabel setLabelFont:KFont(12) textColor:COLOR_UI_000000 textAlignment:NSTextAlignmentLeft];
//        [_contentLabel setTextString:@"小姐姐已经上线拉" AndColorSubString:@"小姐姐" color:COLOR_UI_THEME_RED];
//    }
//    return _contentLabel;
//}

@end
