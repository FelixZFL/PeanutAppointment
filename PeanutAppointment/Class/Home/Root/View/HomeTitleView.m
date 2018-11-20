//
//  HomeTitleView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeTitleView.h"

@interface HomeTitleView()

@property (nonatomic, strong) UILabel *chiniseTitleLabel;

//@property (nonatomic, strong) UILabel *englishTitleLabel;

@end

@implementation HomeTitleView

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
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_UI_THEME_RED;
    [lineView setCorner:CORNER_2];
    [self addSubview:lineView];
    
    [self addSubview:self.chiniseTitleLabel];
//    [self addSubview:self.englishTitleLabel];

    __weak __typeof(self)weakSelf = self;
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(weakSelf.chiniseTitleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(4, 14));
    }];
    
    [self.chiniseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(lineView.mas_right).with.mas_offset(MARGIN_5);
    }];
    
//    [self.englishTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-MARGIN_10);
//        make.left.equalTo(weakSelf.chiniseTitleLabel.mas_left);
//    }];
}

#pragma mark - public -

- (void)setChiniseTitle:(NSString *)cTitle englishTitle:(NSString *)eTitle {
    
    self.chiniseTitleLabel.text = cTitle;
    
//    NSString *upString = [eTitle uppercaseString];
//    self.englishTitleLabel.text = upString;
//    NSArray *array = [upString componentsSeparatedByString:@" "];
//    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:upString];
//    NSInteger loc = 0;
//    for (int i = 0; i < array.count; i++) {
//        [mutableStr addAttribute:NSFontAttributeName value:KFont(15) range:NSMakeRange(loc, 1)];
//        NSString *subStr = array[i];
//        loc += subStr.length + 1;
//    }
//    self.englishTitleLabel.attributedText = mutableStr;
    
}

+ (CGFloat)getHeight {
    
    return 45;
}


#pragma mark - getter -

- (UILabel *)chiniseTitleLabel {
    if (!_chiniseTitleLabel) {
        _chiniseTitleLabel = [[UILabel alloc] init];
        [_chiniseTitleLabel setLabelFont:KFont(17) textColor:COLOR_UI_000000 textAlignment:NSTextAlignmentLeft];
    }
    return _chiniseTitleLabel;
}

//- (UILabel *)englishTitleLabel {
//    if (!_englishTitleLabel) {
//        _englishTitleLabel = [[UILabel alloc] init];
//        [_englishTitleLabel setLabelFont:KFont(10) textColor:COLOR_UI_000000 textAlignment:NSTextAlignmentLeft];
//    }
//    return _englishTitleLabel;
//}

@end
