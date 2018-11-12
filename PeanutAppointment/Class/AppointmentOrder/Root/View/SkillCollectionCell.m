//
//  SkillCollectionCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/2.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "SkillCollectionCell.h"

#import "SkillModel.h"

@interface SkillCollectionCell ()

///技能
@property (nonatomic, strong) UILabel *skillLabel;

@end

@implementation SkillCollectionCell


#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    _skillLabel = [[UILabel alloc] init];
    _skillLabel.textAlignment = NSTextAlignmentCenter;
    _skillLabel.font = KFont(14);
    [self addSubview:_skillLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_skillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - public

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setModel:(SkillModel *)model {
    _model = model;
    _skillLabel.text = model.pasName;
    
    if (model.isSelect) {
        _skillLabel.textColor = COLOR_UI_FFFFFF;
        _skillLabel.layer.borderWidth = 0.0;
        _skillLabel.backgroundColor = COLOR_UI_THEME_RED;
    } else {
        _skillLabel.textColor = [UIColor blackColor];
        _skillLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _skillLabel.layer.borderWidth = 1.0;
        _skillLabel.backgroundColor = COLOR_UI_FFFFFF;
    }
    _skillLabel.layer.cornerRadius = 5.0;
    _skillLabel.layer.masksToBounds = YES;
}


@end
