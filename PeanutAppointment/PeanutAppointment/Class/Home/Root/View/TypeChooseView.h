//
//  TypeChooseView.h
//  ainonggu
//
//  Created by felix on 2018/8/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TypeChooseViewHeight 40

typedef void(^TypeChooseBlock)(NSInteger selectIndex);

@interface TypeChooseView : UIView

///可以点击多次
@property (nonatomic, assign) BOOL canClickMoreTimes;

@property (nonatomic, assign) NSInteger index;

+ (instancetype)typeViewWithTypeArr:(NSArray *)typeArr withSelectIndex:(NSInteger)selectIndex chooseBlock:(TypeChooseBlock)block;

@end
