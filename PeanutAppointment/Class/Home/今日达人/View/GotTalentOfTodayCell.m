//
//  GotTalentOfTodayCell.m
//  PeanutAppointment
//
//  Created by felix on 2018/10/17.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "GotTalentOfTodayCell.h"

#import "GotTalentListModel.h"

@interface GotTalentOfTodayCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIButton *playCountBtn;
@property (nonatomic, strong) UILabel *commentCountLabel;

@end

@implementation GotTalentOfTodayCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageV];
        [self.imageV addSubview:self.playCountBtn];
        [self.imageV addSubview:self.commentCountLabel];
        
        
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        
        [self.playCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MARGIN_10);
            make.bottom.mas_equalTo(-MARGIN_10);
        }];
        
        [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-MARGIN_10);
            make.bottom.mas_equalTo(-MARGIN_10);
        }];
    }
    return self;
}

#pragma mark - public -

- (void)setModel:(GotTalentListModel *)model {
    _model = model;
    
    [self.imageV sd_setImageWithURL:URLWithString(model.voidUrl)];
    [self.playCountBtn setButtonStateNormalTitle:model.playNumber];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@条评论",model.comments];
}

+ (NSString *) reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - getter -

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = COLOR_UI_000000;
        [_imageV setCorner:CORNER_5];
    }
    return _imageV;
}

- (UIButton *)playCountBtn {
    if (!_playCountBtn) {
        _playCountBtn = [[UIButton alloc] init];
        [_playCountBtn setButtonStateNormalTitle:@" 2223" Font:KFont(12) textColor:COLOR_UI_FFFFFF];
        [_playCountBtn setImage:imageNamed(@"starOfToday_video_play") forState:UIControlStateNormal];
    }
    return _playCountBtn;
}

- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [UILabel labelWithFont:KFont(12) textColor:COLOR_UI_FFFFFF textAlignment:NSTextAlignmentRight];
        _commentCountLabel.text = @"20条评论";
    }
    return _commentCountLabel;
}

@end
