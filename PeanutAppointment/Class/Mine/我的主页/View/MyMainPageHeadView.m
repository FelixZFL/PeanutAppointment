//
//  MyMainPageHeadView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/6.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyMainPageHeadView.h"
#import "BaseBottomLineView.h"

#import "MyMainPageModel.h"

@interface MyMainPageHeadView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *headImageV;//头像
@property (nonatomic, strong) UILabel *nickNameLabel;//昵称
@property (nonatomic, strong) UILabel *ageLabel;//年龄
@property (nonatomic, strong) UILabel *genderLabel;//性别

@property (nonatomic, strong) UILabel *addressLabel;//地址
@property (nonatomic, strong) UILabel *authLabel;//认证
@property (nonatomic, strong) UILabel *integralLbabel;//积分
@property (nonatomic, strong) UILabel *visitorCountLabel;//访客
@property (nonatomic, strong) UILabel *likesCountLabel;//点赞数

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<MainPageVisitorModel *> *visitors;//访客数量

@end

@implementation MyMainPageHeadView

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
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    BaseBottomLineView *userView = [[BaseBottomLineView alloc] init];
    [self addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(66);
    }];
    
    [userView addSubview:self.headImageV];
    [userView addSubview:self.nickNameLabel];
    [userView addSubview:self.ageLabel];
    [userView addSubview:self.genderLabel];
    
    __weak __typeof(self)weakSelf = self;
    
    [self.headImageV setCorner:45/2.f];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.centerY.equalTo(userView.mas_centerY);
        make.width.height.mas_equalTo(45);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.top.equalTo(weakSelf.headImageV);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageV.mas_right).with.mas_offset(MARGIN_10);
        make.bottom.equalTo(weakSelf.headImageV.mas_bottom).with.mas_offset(-MARGIN_5);
    }];
    
    [self.genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.ageLabel.mas_right).with.mas_offset(MARGIN_10);
        make.centerY.equalTo(weakSelf.ageLabel.mas_centerY);
    }];
    
    CGFloat titleWidth = 60;
    
    UIView *lastView = userView;
    for (int i = 0; i < 6; i++) {
        
        BaseBottomLineView *view = [[BaseBottomLineView alloc] init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(lastView.mas_bottom);
        }];
        lastView = view;
        
        UILabel *titleLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15);
            make.top.mas_equalTo(MARGIN_15);
            make.width.mas_equalTo(titleWidth);
        }];
        
        UILabel *contentLabel = [UILabel labelWithFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        contentLabel.numberOfLines = 0;
        [view addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_15 + titleWidth + MARGIN_15);
            make.top.mas_equalTo(MARGIN_15);
            make.right.mas_equalTo(-MARGIN_15);
        }];
        
        if (i == 0) {
            titleLabel.text = @"地理位置";
            
            self.addressLabel = contentLabel;
        } else if (i == 1) {
            titleLabel.text = @"个人相册";
            contentLabel.text = @"";
            
            UIImageView *nextImgV = [[UIImageView alloc] init];
            nextImgV.image = imageNamed(@"common_btn_next_more");
            [view addSubview:nextImgV];
            [nextImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-MARGIN_15);
                make.centerY.equalTo(view);
            }];
            
        } else if (i == 2) {
            titleLabel.text = @"认证";
            self.authLabel = contentLabel;
            
        } else if (i == 3) {
            titleLabel.text = @"等级积分";
            contentLabel.textColor = COLOR_UI_THEME_RED;
            self.integralLbabel = contentLabel;
        } else if (i == 4) {
            titleLabel.text = @"访客量";
            contentLabel.textColor = COLOR_UI_THEME_RED;
            self.visitorCountLabel = contentLabel;
            
            CGFloat headWidth = 30;
            
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.itemSize = CGSizeMake(headWidth,headWidth);
            flowLayout.minimumLineSpacing = 10;
            flowLayout.minimumInteritemSpacing = 10;
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
            
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
            [collectionView registerClass:[VisitorHeadCell class] forCellWithReuseIdentifier:[VisitorHeadCell reuseIdentifier]];
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.backgroundColor = COLOR_UI_FFFFFF;
            [view addSubview:collectionView];
            [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(contentLabel.mas_bottom);
                make.left.equalTo(contentLabel);
                make.right.mas_equalTo(MARGIN_15);
                make.bottom.mas_equalTo(0);
            }];
            self.collectionView = collectionView;
            
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(75);
            }];
            
        } else if (i == 5) {
            titleLabel.text = @"已获得赞";
            self.likesCountLabel = contentLabel;
        }
        [titleLabel changeAligmentRightAndLeftWithWidth:titleWidth];
        
    }
    
    
}

#pragma mark - public -

+ (CGFloat )getHeightWithModel:(MyMainPageModel *)model {
    if (model && model.info) {
        CGFloat height = 66 + 40 * 4;
        MyMainPageInfoModel *infoModel = model.info;
        CGFloat titleWidth = 60;
        CGFloat addressHeight = MAX([infoModel.addr getHeightWithMaxWidth:SCREEN_WIDTH - titleWidth - MARGIN_15 * 3 font:KFont(14)] + MARGIN_15 * 2, 40);
        
        height += addressHeight;
        
        CGFloat visitorHeight = model.list.count > 0 ? 75 : 40;
        height += visitorHeight;
        
        return height;
    }
    return 0;
}

- (void)updateWithModel:(MyMainPageModel *)model {
    if (model && model.info) {
        MyMainPageInfoModel *infoModel = model.info;
        [self.headImageV sd_setImageWithURL:URLWithString(infoModel.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
        self.nickNameLabel.text = infoModel.nikeName;
        self.ageLabel.text = [NSString stringWithFormat:@" %@岁 ",infoModel.age?: @"18"];
        self.genderLabel.text = [NSString stringWithFormat:@" %@ ",[infoModel.sex integerValue] == 1 ? @"男" : @"女"];
        
        self.addressLabel.text = infoModel.addr;
        CGFloat titleWidth = 60;
        CGFloat addressHeight = MAX([infoModel.addr getHeightWithMaxWidth:SCREEN_WIDTH - titleWidth - MARGIN_15 * 3 font:KFont(14)] + MARGIN_15 * 2, 40);
        [self.addressLabel.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(addressHeight);
        }];
        
        [self setAuthImageWithModel:infoModel];
//        self.integralLbabel.text = infoModel.
        self.visitorCountLabel.text = infoModel.fwNumber;
        self.likesCountLabel.text = infoModel.likeSumNumber;
        
        self.visitors = model.list;
        [self.collectionView reloadData];
        
        [self.collectionView.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(model.list.count > 0 ? 75 : 40);
        }];
    }
    
}

- (void)setAuthImageWithModel:(MyMainPageInfoModel *)model {
    
    NSMutableArray *authImages = [NSMutableArray array];
    if (model.phone.length > 0) {//手机认证
        [authImages addObject:imageNamed(@"personalAuth_icon_phone")];
    }
    if (model.wxNumber.length > 0) {//微信认证
        [authImages addObject:imageNamed(@"personalAuth_icon_weichat")];
    }
    if ([model.isCertification integerValue] == 1) {//身份认证
        [authImages addObject:imageNamed(@"personalAuth_icon_idCard")];
    }
    if (model.aliPayNumber.length > 0) {//支付宝认证
        [authImages addObject:imageNamed(@"personalAuth_icon_alipay")];
    }
//    if ([model.xxx integerValue] == 1) {//技能认证
//        [authImages addObject:imageNamed(@"personalAuth_icon_skill")];
//    }
    
    [self.authLabel setAuthImages:authImages];
}

#pragma mark - ============= UICollectionViewDataSource,UICollectionViewDelegate ===============

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return floorf((SCREEN_WIDTH - 105)/(30+10));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VisitorHeadCell *cell = (VisitorHeadCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[VisitorHeadCell reuseIdentifier] forIndexPath:indexPath];
    }
    cell.headImageV.hidden = indexPath.row >= self.visitors.count;
    
    if (self.visitors.count > indexPath.row) {
        MainPageVisitorModel *model = self.visitors[indexPath.row];
        [cell.headImageV sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    }
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark - action -

#pragma mark - getter -

- (UIImageView *)headImageV {
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] init];
        _headImageV.image = imageNamed(placeHolderHeadImageName);
    }
    return _headImageV;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        [_nickNameLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
        _nickNameLabel.text = @"";
    }
    return _nickNameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        [_ageLabel setLabelFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _ageLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_ageLabel setDefaultCorner];
        _ageLabel.text = @"";
    }
    return _ageLabel;
}

- (UILabel *)genderLabel {
    if (!_genderLabel) {
        _genderLabel = [[UILabel alloc] init];
        [_genderLabel setLabelFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentLeft];
        _genderLabel.backgroundColor = COLOR_UI_THEME_RED;
        [_genderLabel setDefaultCorner];
        _genderLabel.text = @"";
    }
    return _genderLabel;
}

@end



@implementation VisitorHeadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headImageV = [[UIImageView alloc] init];
        [self.headImageV setCorner:15.f];
        self.headImageV.image = imageNamed(placeHolderHeadImageName);
        [self addSubview:self.headImageV];
        [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}


@end

