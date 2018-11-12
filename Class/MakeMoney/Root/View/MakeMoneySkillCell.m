//
//  MakeMoneySkillCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/26.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MakeMoneySkillCell.h"

#import "MakeMoneySkillModel.h"

@interface MakeMoneySkillCell()

@property (nonatomic, strong) UILabel *skillNameLabel;

@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation MakeMoneySkillCell

#pragma mark - lifeCycle -
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    self.skillNameLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    self.skillNameLabel.text = @"品美酒";
    [self addSubview:self.skillNameLabel];
    
    self.editBtn = [UIButton buttonStateNormalTitle:@" 编辑" Font:KFont(14) textColor:COLOR_UI_666666];
    [self.editBtn setButtonStateNormalImage:imageNamed(@"makeMoney_btn_edit")];
    [self.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];
    
    self.deleteBtn = [UIButton buttonStateNormalTitle:@" 删除" Font:KFont(14) textColor:COLOR_UI_666666];
    [self.deleteBtn setButtonStateNormalImage:imageNamed(@"makeMoney_btn_delete")];
    [self.editBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.equalTo(weakSelf.deleteBtn.mas_left).with.mas_offset(-MARGIN_20);
    }];
    
    [self.skillNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(MARGIN_15);
        make.right.lessThanOrEqualTo(weakSelf.editBtn.mas_left);
    }];
    
    [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
    }];
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return 44;
}

- (void)setModel:(MakeMoneySkillModel *)model {
    _model = model;
    self.skillNameLabel.text = model.jnName;
}

#pragma mark -- action

- (void)editBtnAction:(UIButton *)sender {
    
    if (self.editBlock) {
        self.editBlock(self.model);
    }
    
}

- (void)deleteBtnAction:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock(self.model);
    }
}

#pragma mark - getter -


@end
