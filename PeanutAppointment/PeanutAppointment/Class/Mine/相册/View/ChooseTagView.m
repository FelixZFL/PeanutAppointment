//
//  ChooseTagView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "ChooseTagView.h"

#import "PhotoTypeListModel.h"

#define kBtnTag 65478


@interface ChooseTagView()

// 选中标签文字颜色
@property (nonatomic, strong) UIColor *textColorSelected;
// 默认标签文字颜色
@property (nonatomic, strong) UIColor* textColorNormal;
// 选中标签背景颜色
@property (nonatomic, strong) UIColor* backgroundColorSelected;
// 默认标签背景颜色
@property (nonatomic, strong) UIColor* backgroundColorNormal;


@end

@implementation ChooseTagView

- (instancetype)initWithFrame:(CGRect)frame
                     tagArray:(NSMutableArray*)tagArray
            textColorSelected:(UIColor *)textColorSelected
              textColorNormal:(UIColor *)textColorNormal
      backgroundColorSelected:(UIColor *)backgroundColorSelected
        backgroundColorNormal:(UIColor *)backgroundColorNormal{
    self = [super initWithFrame:frame];
    if (self) {
        _tagArray = tagArray;
        
        _textColorSelected = textColorSelected;
        _textColorNormal = textColorNormal;
        _backgroundColorSelected = backgroundColorSelected;
        _backgroundColorNormal = backgroundColorNormal;
        // 创建标签按钮
        [self createTagButton];
    }
    return self;
}

- (void)setTagArray:(NSArray *)tagArray {
    _tagArray = tagArray;
    
    // 重新创建标签
    [self resetTagButton];
}

+ (CGFloat )getHeightWithTagArray:(NSArray *)tagArray maxWidth:(CGFloat )maxWidth{
    
    if (tagArray.count > 0) {
        
        CGFloat maxHeight = 0;
        
        // 按钮高度
        CGFloat btnH = 28;
        // 距离左边距
        CGFloat leftX = 6;
        // 距离上边距
        CGFloat topY = 10;
        // 按钮左右间隙
        CGFloat marginX = 10;
        // 按钮上下间隙
        CGFloat marginY = 10;
        // 文字左右间隙
        CGFloat fontMargin = 10;
        
        for (int i = 0; i < tagArray.count; i++) {
            PhotoTypeListModel *model = tagArray[i];
            
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
            // 按钮文字
            [btn setTitle:model.typeName?:@"" forState:UIControlStateNormal];
            
            //按钮文字默认样式
            NSMutableAttributedString* btnDefaultAttr = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text];
            // 文字大小
            [btnDefaultAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, btn.titleLabel.text.length)];
            
            [btn setAttributedTitle:btnDefaultAttr forState:UIControlStateNormal];
            
            // 设置按钮的边距、间隙
            [self setTagButtonMargin:btn fontMargin:fontMargin maxWidth:maxWidth];
            
            // 处理换行
            if (btn.frame.origin.x + btn.frame.size.width + marginX > maxWidth) {
                // 换行
                topY += btnH + marginY;
                
                // 重置
                leftX = 6;
                btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
                
                // 设置按钮的边距、间隙
                [self setTagButtonMargin:btn fontMargin:fontMargin maxWidth:maxWidth];
            }
            
            // 重置高度
            CGRect frame = btn.frame;
            frame.size.height = btnH;
            btn.frame = frame;
            
            leftX += btn.frame.size.width + marginX;
            
            maxHeight = CGRectGetMaxY(btn.frame) + marginY;
        }
        
        return maxHeight;
    }
    return 0;
}

#pragma mark - Private

// 重新创建标签
- (void)resetTagButton{
    
    // 移除之前的标签
    for (UIButton* btn  in self.subviews) {
        [btn removeFromSuperview];
    }
    _selectedTagIndex = 0;
    // 重新创建标签
    [self createTagButton];
}


// 创建标签按钮
- (void)createTagButton{
    
    // 按钮高度
    CGFloat btnH = 28;
    // 距离左边距
    CGFloat leftX = 6;
    // 距离上边距
    CGFloat topY = 10;
    // 按钮左右间隙
    CGFloat marginX = 10;
    // 按钮上下间隙
    CGFloat marginY = 10;
    // 文字左右间隙
    CGFloat fontMargin = 10;
    
    for (int i = 0; i < _tagArray.count; i++) {
        
        PhotoTypeListModel *model = _tagArray[i];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
        btn.tag = kBtnTag+i;
        // 默认选中第一个
        if (i == 0) {
            btn.selected = YES;
        }
        
        // 按钮文字
        [btn setTitle:model.typeName?:@"" forState:UIControlStateNormal];
        
        //------ 默认样式
        //按钮文字默认样式
        NSMutableAttributedString* btnDefaultAttr = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text];
        // 文字大小
        [btnDefaultAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, btn.titleLabel.text.length)];
        // 默认颜色
        [btnDefaultAttr addAttribute:NSForegroundColorAttributeName value:self.textColorNormal range:NSMakeRange(0, btn.titleLabel.text.length)];
        [btn setAttributedTitle:btnDefaultAttr forState:UIControlStateNormal];
        
        // 默认背景颜色
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorNormal] forState:UIControlStateNormal];
        
        //-----  选中样式
        // 选中字体颜色
        NSMutableAttributedString* btnSelectedAttr = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text];
        // 选中颜色
        [btnSelectedAttr addAttribute:NSForegroundColorAttributeName value:self.textColorSelected range:NSMakeRange(0, btn.titleLabel.text.length)];
        // 选中文字大小
        [btnSelectedAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, btn.titleLabel.text.length)];
        [btn setAttributedTitle:btnSelectedAttr forState:UIControlStateSelected];
        
        // 选中背景颜色
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorSelected] forState:UIControlStateSelected];
        
        // 圆角
        btn.layer.cornerRadius = btn.frame.size.height / 2.f;
        btn.layer.masksToBounds = YES;
        // 边框
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        
        // 设置按钮的边距、间隙
        [ChooseTagView setTagButtonMargin:btn fontMargin:fontMargin maxWidth:self.frame.size.width];
        
        // 处理换行
        if (btn.frame.origin.x + btn.frame.size.width + marginX > self.frame.size.width) {
            // 换行
            topY += btnH + marginY;
            
            // 重置
            leftX = 6;
            btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
            
            // 设置按钮的边距、间隙
            [ChooseTagView setTagButtonMargin:btn fontMargin:fontMargin maxWidth:self.frame.size.width];
        }
        
        // 重置高度
        CGRect frame = btn.frame;
        frame.size.height = btnH;
        btn.frame = frame;
        
        //----- 选中事件
        [btn addTarget:self action:@selector(selectdButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        leftX += btn.frame.size.width + marginX;
    }
}

// 设置按钮的边距、间隙
+ (void)setTagButtonMargin:(UIButton*)btn fontMargin:(CGFloat)fontMargin maxWidth:(CGFloat)maxWidth{
    
    // 按钮自适应
    [btn sizeToFit];
    
    // 重新计算按钮文字左右间隙
    CGRect frame = btn.frame;
    frame.size.width += fontMargin*2;
    if (frame.size.width > maxWidth) {
        frame.size.width = maxWidth;
    }
    btn.frame = frame;
}

// 检测按钮状态，最少选中一个
//- (void)checkButtonState{
//
//    int selectCount = 0;
//    UIButton* selectedBtn = nil;
//    for(int i=0;i < _tagArray.count; i++){
//        UIButton* btn = (UIButton*)[self viewWithTag:kBtnTag+i];
//        if(btn.selected){
//            selectCount++;
//            selectedBtn = btn;
//        }
//    }
//    if (selectCount == 1) {
//        // 只有一个就把这一个给禁用手势
//        selectedBtn.userInteractionEnabled = NO;
//    } else {
//        // 解除禁用手势
//        for(int i=0;i < _tagArray.count; i++){
//            UIButton* btn = (UIButton*)[self viewWithTag:kBtnTag+i];
//            if(!btn.userInteractionEnabled){
//                btn.userInteractionEnabled = YES;
//            }
//        }
//    }
//}

// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Event

// 标签按钮点击事件
- (void)selectdButton:(UIButton*)sender{
    
    if (sender.selected) {
        return;
    }
    for (UIButton *btn in self.subviews) {
        if (sender == btn) {
            [btn setSelected:YES];
            _selectedTagIndex = btn.tag - kBtnTag;
        } else {
            [btn setSelected:NO];
        }
    }
//    sender.selected = !sender.selected;
//
//    // 检测按钮状态，最少选中一个
//    [self checkButtonState];
}


@end
