//
//  TypeChooseView.m
//  ainonggu
//
//  Created by felix on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "TypeChooseView.h"

@interface TypeChooseView()

@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) TypeChooseBlock chooseBlock;


@property (nonatomic, strong) UIView *btnBottomLine;
@property (nonatomic, strong) UIButton *selectBtn;


@end

@implementation TypeChooseView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR_UI_FFFFFF;
    }
    return self;
}

#pragma mark - UI -

- (void)setupUI {
    
    if (self.typeArr.count < 2) {
        return;
    }
    if (self.selectIndex >= self.typeArr.count || self.selectIndex < 0) {
        return;
    }
    
    
    CGFloat btnW = SCREEN_WIDTH/self.typeArr.count;
    
    for (int i = 0; i < self.typeArr.count; i++) {
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeBtn setTitle:self.typeArr[i] forState:UIControlStateNormal];
        [typeBtn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
        [typeBtn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateSelected];
        typeBtn.titleLabel.font = KFont(14);
        typeBtn.tag = 888 + i;
        [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:typeBtn];
        typeBtn.frame = CGRectMake(btnW * i, 0, btnW, TypeChooseViewHeight);
        if (self.selectIndex == i) {
            typeBtn.selected = YES;
            self.selectBtn = typeBtn;
        }
    }
    
    UIView *btnBottomLine = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_10, TypeChooseViewHeight - LINE_HEIGHT_3, 80, LINE_HEIGHT_3)];
    btnBottomLine.backgroundColor = COLOR_UI_THEME_RED;
    [btnBottomLine setCorner:LINE_HEIGHT_3/2.f];
    btnBottomLine.centerX = self.selectBtn.centerX;
    [self addSubview:btnBottomLine];
    self.btnBottomLine = btnBottomLine;
    
}

#pragma mark - public -

+ (instancetype)typeViewWithTypeArr:(NSArray *)typeArr withSelectIndex:(NSInteger)selectIndex chooseBlock:(TypeChooseBlock)block {
    TypeChooseView *view = [[TypeChooseView alloc] init];
    view.typeArr = typeArr;
    view.selectIndex = selectIndex;
    view.chooseBlock = block;
    [view setupUI];
    return view;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    for (UIButton *btn in self.subviews) {
        if (btn.tag - 888 == index) {
            [self typeBtnAction:btn];
        }
    }
}

#pragma mark - action -
- (void)typeBtnAction:(UIButton *)btn {
    
    if (self.selectBtn.tag == btn.tag) {
        return;
    }
    
    self.selectBtn.selected = NO;
    
    btn.selected = YES;
    self.selectBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btnBottomLine.centerX = btn.centerX;
    }];
    
    if (self.chooseBlock) {
        self.chooseBlock(btn.tag - 888);
    }
}
@end
