//
//  MyInfoCell.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyInfoCell.h"

#define SingleViewHeight 45.f

@interface MyInfoCell()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *genderLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UITextField *nickNameTF;

@end

@implementation MyInfoCell

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
    
    for (int i = 0; i < 4; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(i * SingleViewHeight);
            make.height.mas_equalTo(SingleViewHeight);
        }];
        
        CGFloat titleWidth = 50;
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.centerY.equalTo(singleView);
            make.width.mas_equalTo(titleWidth);
        }];
        
        
        if (i == 1) {
            
            titleLabel.text = @"昵称";
            
            UIButton *editBtn = [[UIButton alloc] init];
            [editBtn setButtonStateNormalImage:imageNamed(@"makeMoney_btn_edit")];
            [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [singleView addSubview:editBtn];
            [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.mas_equalTo(0);
                make.width.mas_equalTo(SingleViewHeight);
            }];
            
            UITextField *textField = [[UITextField alloc] init];
            textField.font = KFont(14);
            textField.textColor = COLOR_UI_222222;
            [singleView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_20);
                make.right.equalTo(editBtn.mas_left);
                make.centerY.equalTo(singleView);
            }];
            self.nickNameTF = textField;
            textField.text = @"可以修改的昵称";
            
            
            
        } else {
            
            UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(titleLabel.mas_right).with.mas_offset(MARGIN_20);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(singleView);
            }];
            if (i == 0) {
                titleLabel.text = @"用户名";
                self.userNameLabel = contentLabel;
                contentLabel.text = @"152326232";
            } else if (i == 2) {
                titleLabel.text = @"性别";
                self.genderLabel = contentLabel;
                contentLabel.text = @"男";
            } else if (i == 3) {
                titleLabel.text = @"年龄";
                self.ageLabel = contentLabel;
                contentLabel.text = @"23";
            }
        }
        
        [titleLabel changeAligmentRightAndLeftWithWidth:titleWidth];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = COLOR_UI_F0F0F0;
        [singleView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
    }
    
}

#pragma mark - public -

+ (CGFloat)getCellHeight {
    
    return SingleViewHeight * 4;
}

- (void)editBtnAction:(id)sender {
    [self.nickNameTF becomeFirstResponder];
}

#pragma mark - getter -

@end
