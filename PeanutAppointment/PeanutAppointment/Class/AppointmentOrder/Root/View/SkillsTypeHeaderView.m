//
//  SkillsTypeHeaderView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "SkillsTypeHeaderView.h"
#import "HomeTitleView.h"

#import "SkillTypesModel.h"

@interface SkillsTypeHeaderView ()

@property (strong , nonatomic) HomeTitleView *titleView;

@end

@implementation SkillsTypeHeaderView


#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    CGFloat titleHeight = [HomeTitleView getHeight] - 20;
    HomeTitleView *titleView = [[HomeTitleView alloc] init];
    [titleView setChiniseTitle:@"" englishTitle:@"Nine Street"];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(titleHeight);
    }];
    self.titleView = titleView;
}

#pragma mark - public

+ (CGFloat)getHeight {
    return [HomeTitleView getHeight] - 20;
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setTypesModel:(SkillTypesModel *)typesModel {
    _typesModel = typesModel;
    [self.titleView setChiniseTitle:typesModel.pasName englishTitle:@"Nine Street"];
}

@end
