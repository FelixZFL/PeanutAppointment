//
//  ChooseTagView.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/8.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseTagView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                     tagArray:(NSMutableArray*)tagArray
            textColorSelected:(UIColor *)textColorSelected
              textColorNormal:(UIColor *)textColorNormal
      backgroundColorSelected:(UIColor *)backgroundColorSelected
        backgroundColorNormal:(UIColor *)backgroundColorNormal;

///选中标签
@property (nonatomic, assign) NSInteger selectedTagIndex;

// 标签数组
@property (nonatomic, strong) NSArray *tagArray;

+ (CGFloat )getHeightWithTagArray:(NSArray *)tagArray maxWidth:(CGFloat )maxWidth;

@end

NS_ASSUME_NONNULL_END
