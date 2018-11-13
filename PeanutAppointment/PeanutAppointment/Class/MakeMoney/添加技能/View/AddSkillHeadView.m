//
//  AddSkillHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddSkillHeadView.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define kImageVTag 74784

@interface AddSkillHeadView()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *serverTypeView;//服务方式视图
@property (nonatomic, strong) UIView *serverPriceUnitView;//计价单位视图
@property (nonatomic, strong) UIView *serverTimeView;//服务时间视图
@property (nonatomic, strong) UIView *photoView;//照片视图

@end

@implementation AddSkillHeadView

#pragma mark - lifeCycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
    }
    return self;
    
}
#pragma mark - UI -

- (void)setupUI {
    
    CGFloat marginLeft = 85;
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    UIView *lastView = nil;
    
    NSArray *titleArray = @[@"技能名称",@"服务方式（多选）",@"服务订金",@"服务价格",@"计价单位",@"服务时间（多选）",@"服务经历",@"服务介绍",@"上传图片",@"个人介绍"];
    
    CGFloat btnHeight = 30;
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *singleView = [[UIView alloc] init];
        [self addSubview:singleView];
        [singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            i == 0 ? make.top.mas_equalTo(0) : make.top.equalTo(lastView.mas_bottom);
            make.height.mas_equalTo(35);
        }];
        
        UIView *lineView = [UIView viewWithColor:COLOR_UI_F0F0F0];
        [singleView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_HEIGHT);
        }];
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        titleLabel.numberOfLines = 0;
        titleLabel.text = titleArray[i];
        [singleView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_10);
            make.width.mas_equalTo(60);
        }];
        
        if (i == 0) {
            
            UILabel *label = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_THEME_RED textAlignment:NSTextAlignmentLeft];
            [singleView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(titleLabel);
            }];
            self.skillNameLabel = label;
            
        } else if (i == 1 || i == 4) {
            
            NSArray *nameArray = i == 1 ? @[@"Ta来找我",@"我去找Ta"] : @[@"元/次",@"元/小时"];
            CGFloat btnWidth = 75;
            for (int j = 0; j < nameArray.count; j++) {
                UIButton *btn = [self getSingleBtn];
                [btn setButtonStateNormalTitle:nameArray[j]];
                btn.selected = j == 0;
                btn.tag = 1 + j;
                SEL action = i == 1 ? @selector(serverTypeClickAction:) : @selector(priceUnitClickAction:) ;
                [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
                [singleView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j * (btnWidth + MARGIN_5));
                    make.centerY.equalTo(singleView);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(55);
            }];
            if (i == 1) {//服务方式
                self.serverTypeView = singleView;
                self.serverType = 1;
            } else {//计价单位
                self.serverPriceUnitView = singleView;
                self.PriceUnit = 1;
            }
            
        } else if (i == 2 || i == 3) {
            
            UITextField *textField = [UITextField textFieldWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
            textField.keyboardType = UIKeyboardTypeNumberPad;
            [singleView addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.top.bottom.mas_equalTo(0);
            }];
            if (i == 2) {
                textField.placeholder = @"请输入订金单位元";
                self.depositTF = textField;
            } else {
                textField.placeholder = @"请输入服务单位元";
                self.priceTF = textField;
            }
            
        } else if (i == 5) {
            NSArray *nameArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
            CGFloat btnWidth = 75;
            if ((SCREEN_WIDTH - marginLeft - MARGIN_15 - MARGIN_5 * 3)/4 < btnWidth) {
                btnWidth = (SCREEN_WIDTH - marginLeft - MARGIN_15 - MARGIN_5 * 3)/4;
            }
            for (int j = 0; j < nameArray.count; j++) {
                UIButton *btn = [self getSingleBtn];
                [btn setButtonStateNormalTitle:nameArray[j]];
                btn.selected = j == 0;
                btn.tag = 1 + j;
                [btn addTarget:self action:@selector(serverTimeClickAction:) forControlEvents:UIControlEventTouchUpInside];
                [singleView addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j%4 * (btnWidth + MARGIN_5));
                    make.top.mas_equalTo(MARGIN_10 + j/4 * (btnHeight + MARGIN_15));
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((MARGIN_10 + btnHeight) * 2 + MARGIN_15);
            }];
            self.serverTimeView = singleView;
            self.serverDaysArray = @[@"1"];
        } else if (i == 6  || i == 7 || i == 9) {
            CustomPlaceholderTextView *textV = [[CustomPlaceholderTextView alloc] init];
            if (i == 6) {
                textV.placeholder = @"告诉用户具体己能经历让他人更容易信任你哟";
                self.serverExperienceTextV = textV;
            } else if (i == 7) {
                textV.placeholder = @"随便说说吧（最多150字）";
                self.serverIntroduceTextV = textV;
            } else {
                textV.placeholder = @"尽可能多的介绍您的个人特点、获得证书、获 奖经历、参赛经历、业务经历等（最多500字）";
                self.personalIntroductionTextV = textV;
            }
            [singleView addSubview:textV];
            [textV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
            }];
        } else if (i == 8) {
            UILabel *hintLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_999999 textAlignment:NSTextAlignmentLeft];
            hintLabel.text = @"请上传描述该技能相关得图片";
            [singleView addSubview:hintLabel];
            [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(marginLeft);
                make.right.mas_equalTo(-MARGIN_15);
                make.top.mas_equalTo(0);
                make.height.mas_equalTo(35);
            }];
            
            CGFloat imageWidth = 65;
            CGFloat imageMarginX = (SCREEN_WIDTH - marginLeft - MARGIN_15 - imageWidth * 3)/2;
            for (int j = 0; j < 3; j++) {
                UIImageView *imageV = [[UIImageView alloc] init];
                imageV.image = imageNamed(@"common_btn_addPhoto");
                imageV.tag = kImageVTag + j;
                imageV.userInteractionEnabled = YES;
                [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoTapAction:)]];
                [singleView addSubview:imageV];
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(marginLeft + j * (imageWidth + imageMarginX));
                    make.top.equalTo(hintLabel.mas_bottom);
                    make.width.height.mas_equalTo(imageWidth);
                }];
                imageV.hidden = j > 0;
            }
            [singleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(35 + imageWidth + MARGIN_10);
            }];
            self.photoView = singleView;
        }
        lastView = singleView;
    }
}

#pragma mark - public -

+ (CGFloat)getHeight {
    CGFloat height6 = (MARGIN_10 + 30) * 2 + MARGIN_15;
    CGFloat height9 = 35 + 65 + MARGIN_10;
    return  35 * 3 + 55 * 2 + height6 + 100 * 3 + height9;
}

#pragma mark - action -
//服务方式
- (void)serverTypeClickAction:(UIButton *)sender {
    
    if (sender.selected && self.serverType != 3) {
        return;
    }
    [sender setSelected:!sender.selected];
    
    NSInteger chooseCount = 0;
    for (UIView *view in self.serverTypeView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if ([(UIButton *)view isSelected]) {
                self.serverType = view.tag;
                chooseCount++;
            }
        }
    }
    if (chooseCount == 2) {
        self.serverType = 3;
    }
    
}
//计价单位
- (void)priceUnitClickAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    for (UIView *view in self.serverPriceUnitView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (sender == view) {
                [(UIButton *)view setSelected:YES];
                self.PriceUnit = sender.tag;
            } else {
                [(UIButton *)view setSelected:NO];
            }
        }
    }
}

- (void)serverTimeClickAction:(UIButton *)sender {
    
    if (sender.selected && self.serverDaysArray.count <= 1) {
        return;
    }
    
    [sender setSelected:!sender.selected];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1];
    for (UIView *view in self.serverTimeView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if ([(UIButton *)view isSelected]) {
                [mArray addObject:[NSString stringWithFormat:@"%ld",(long)view.tag]];
            }
        }
    }
    self.serverDaysArray = mArray;
}

- (void)addPhotoTapAction:(UIGestureRecognizer *)gesture {
    UIImageView *imageV = (UIImageView *)gesture.view;
    if (self.photosArray.count > imageV.tag - kImageVTag) {
        //TODO 预览
    } else {
        TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:3 - self.photosArray.count delegate:self];
        [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [self.photosArray addObjectsFromArray:photos];
            [self updatePhotoView];
        }];
        [self.topViewController presentViewController:imagePickerVC animated:YES completion:nil];
    }
}

#pragma mark - private -

- (void)updatePhotoView {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.photosArray];
    
    [tempArray addObject:imageNamed(@"common_btn_addPhoto")];
    
    for (UIView *view in self.photoView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imageV = (UIImageView *)view;
            if (tempArray.count > imageV.tag - kImageVTag) {
                imageV.image = tempArray[imageV.tag - kImageVTag];
                imageV.hidden = NO;
            } else {
                imageV.hidden = YES;
            }
        }
    }
}

- (UIButton *)getSingleBtn {
    UIButton *btn = [[UIButton alloc] init];
    [btn setButtonStateNormalTitle:@"" Font:KFont(14) textColor:COLOR_UI_666666];
    [btn setborderColor:COLOR_UI_999999];
    [btn setDefaultCorner];
    [btn setBackgroundImage:[UIImage createImageWithColor:COLOR_UI_FFFFFF] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage createImageWithColor:COLOR_UI_THEME_RED] forState:UIControlStateSelected];
    [btn setTitleColor:COLOR_UI_666666 forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateSelected];
    return btn;
}

#pragma mark - getter -

- (NSMutableArray *)photosArray {
    if (!_photosArray) {
        _photosArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _photosArray;
}

@end
