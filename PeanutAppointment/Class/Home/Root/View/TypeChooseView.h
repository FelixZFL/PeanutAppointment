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

@property (nonatomic, assign) NSInteger index;

+ (instancetype)typeViewWithTypeArr:(NSArray *)typeArr withSelectIndex:(NSInteger)selectIndex chooseBlock:(TypeChooseBlock)block;

@end
