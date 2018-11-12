//
//  HomeSectionHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/24.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "HomeSectionHeadView.h"

@interface HomeSectionHeadView()

@end

@implementation HomeSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -

- (void)setupUI {
    
    self.contentView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.typeView = [TypeChooseView typeViewWithTypeArr:@[@"智能排序",@"筛选"] withSelectIndex:0 chooseBlock:^(NSInteger selectIndex) {
        
    }];
    [self addSubview:self.typeView];
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(TypeChooseViewHeight);
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = COLOR_UI_F0F0F0;
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    
}

#pragma mark - public -

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)getHeight {
    return TypeChooseViewHeight;
}

#pragma mark - getter -


@end
