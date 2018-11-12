//
//  AlivcLiveBeautifySettingsView.m
//  BeautifySettingsPanel
//
//  Created by 汪潇翔 on 2018/5/29.
//  Copyright © 2018 汪潇翔. All rights reserved.
//

#import "AlivcLiveBeautifySettingsView.h"
#import "_AlivcLiveBeautifyLevelView.h"
#import "_AlivcLiveBeautifyDetailView.h"
#import "_AlivcLiveBeautifyNavigationView.h"
#import "_AlivcLiveBeautifySliderView.h"
#import "NSString+AlivcHelper.h"
@interface AlivcLiveBeautifySettingsView()
<_AlivcLiveBeautifySliderViewDelegate,
_AlivcLiveBeautifyDetailViewDelegate,
_AlivcLiveBeautifyDetailViewDataSource,
_AlivcLiveBeautifyLevelViewDelegate>

/** 美颜等级视图 */
@property (nonatomic, strong)_AlivcLiveBeautifyLevelView *levelView;

/** 美颜微调视图 */
@property (nonatomic, strong)_AlivcLiveBeautifyDetailView *detailView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) _AlivcLiveBeautifySliderView *sliderView;

@property (nonatomic, assign) BOOL detailIsShow;

@property (nonatomic, strong) NSMutableDictionary *selectInfo;

@end

@implementation AlivcLiveBeautifySettingsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_contentView];
        
        _levelView = [[_AlivcLiveBeautifyLevelView alloc] initWithFrame:CGRectZero];
        _levelView.delegate = self;
        _levelView.level = 0;
        
        __weak typeof(self) weakSelf = self;        
        [_levelView.navigationView setRightImage:[UIImage imageNamed:@"ic_adjust"] action:^(_AlivcLiveBeautifyNavigationView *sender) {
            [weakSelf showDetailView];
        }];
        [_contentView addSubview:_levelView];
    }
    return self;
}

- (void)setLevel:(NSInteger)level{
    if (_level != level) {
         _level = level;
        self.levelView.level = level;
    }
}

- (void)setDetailItems:(NSArray<NSMutableDictionary *> *)detailItems{
    _detailItems = detailItems;
    [self realodData];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsLayout];
}

- (void)setDataSource:(id<AlivcLiveBeautifySettingsViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        NSArray<NSDictionary *> *items = [self.dataSource detailItemsOfSettingsView:self];
        
        NSMutableArray<NSMutableDictionary *> *detailItems = [NSMutableArray arrayWithCapacity:items.count];
        for (NSDictionary *item in items) {
            NSMutableDictionary *dict = [item mutableCopy];
            dict[@"originalValue"] = dict[@"value"];
            [detailItems addObject:dict];
        }
        self.detailItems = detailItems;
        [_detailView reloadData];
    }
}

- (void)realodData{
    [_detailView reloadData];
}


- (void)showDetailView {
    if (_detailView) {
        [_detailView removeFromSuperview];
        _detailView = nil;
    }
    
    CGRect frame = _contentView.bounds;
    _detailView = [[_AlivcLiveBeautifyDetailView alloc] initWithFrame:CGRectOffset(frame, CGRectGetWidth(frame), 0)];
    _detailView.delegate = self;
    _detailView.dataSource = self;
    __weak typeof(self) weakSelf = self;
    [_detailView.navigationView setLeftImage:[UIImage imageNamed:@"avcBackIcon"]
                                       title:[@"Face Filter" localString]
                                      action:^(_AlivcLiveBeautifyNavigationView *sender) {
                                          [weakSelf.sliderView removeFromSuperview];
                                          weakSelf.sliderView = nil;
                                          [weakSelf showLevelView];
                                      }];
    
    [_detailView.navigationView setRightImage:[UIImage imageNamed:@"ic_reset"]
                                       action:^(_AlivcLiveBeautifyNavigationView *sender) {
                                           [weakSelf _resetSlider];
                                       }];
    
    
    [_contentView addSubview:_detailView];
    [_detailView reloadData];
    
    self.detailIsShow = YES;
    [UIView animateWithDuration:0.27f
                     animations:^{
                         self->_detailView.frame = frame;
                         self->_levelView.frame = CGRectOffset(frame, -CGRectGetWidth(frame), 0);
                     } completion:^(BOOL finished) {
                         self->_detailView.frame = frame;
                         self->_levelView.frame = CGRectOffset(frame, -CGRectGetWidth(frame), 0);
                     }];
}

- (void)showLevelView {
    CGRect frame = _contentView.bounds;
    self.detailIsShow = NO;
    [UIView animateWithDuration:0.27f
                     animations:^{
                         self->_levelView.frame = frame;
                         self->_detailView.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
                     } completion:^(BOOL finished) {
                         self->_levelView.frame = frame;
                         self->_detailView.frame = CGRectOffset(frame, CGRectGetWidth(frame), 0);
                     }];
}



- (void)layoutSubviews {
    //没高度就别布局了
    if (CGRectEqualToRect(self.bounds, CGRectZero) ) {
        return;
    }
    
    
    if (_sliderView) {
        _sliderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 78.f);
    }
    _contentView.frame = CGRectMake(0,
                                    78.f,
                                    CGRectGetWidth(self.bounds),
                                    CGRectGetHeight(self.bounds) - 78.f);
    if (_levelView) {
        CGRect frame = _contentView.bounds;
        if (_detailIsShow) {
            frame = CGRectMake(-frame.size.width, 0, frame.size.width, frame.size.height);
        }
        _levelView.frame = frame;
    }
    
    if (_detailView) {
        CGRect frame = _contentView.bounds;
        if (!_detailIsShow) {
            frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
        }
        _detailView.frame = frame;
    }
}

- (void)_resetSlider {
    if (_sliderView) {
        _sliderView.value = _sliderView.originalValue;
    }
    if ([self.sliderView.delegate respondsToSelector:@selector(sliderViewTouchDidCancel:)]) {
        [self.sliderView.delegate sliderViewTouchDidCancel:self.sliderView];
    }
}

#pragma mark - Setter & Getter
- (void)setDetailIsShow:(BOOL)detailIsShow {
    if (_detailIsShow != detailIsShow) {
        _detailIsShow = detailIsShow;
        _sliderView.hidden = !detailIsShow;
    }
}

#pragma mark - _AlivcLiveBeautifySliderViewDelegate

- (void)sliderView:(_AlivcLiveBeautifySliderView *)sliderView valueDidChange:(float)value {
    
}

- (void)sliderViewTouchDidCancel:(_AlivcLiveBeautifySliderView *)sliderView  {
    if (self.selectInfo) {
        self.selectInfo[@"value"] = @(sliderView.value);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingsView:didChangeValue:)]) {
        [self.delegate settingsView:self didChangeValue:self.selectInfo];
    }
}

#pragma mark - _AlivcLiveBeautifyDetailViewDelegate
- (void)detailView:(_AlivcLiveBeautifyDetailView *)detailView didSelectItemAtIndex:(NSUInteger)index {
    [self _aliDetailView:detailView didSelectItemAtIndex:index];
}

- (void)_aliDetailView:(_AlivcLiveBeautifyDetailView *)view didSelectItemAtIndex:(NSUInteger)index {
    if (!_sliderView) {
        _sliderView = [[_AlivcLiveBeautifySliderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 78.f)];
        _sliderView.delegate = self;
        [self addSubview:_sliderView];
    }
    
    NSMutableDictionary *info = _detailItems[index];
    self.selectInfo = info;
    /*
     @"value":@(0),
     @"minimumValue":@(0),
     @"maximumValue":@(100),
     */
    _sliderView.value = [info[@"value"] floatValue];
    _sliderView.originalValue = [info[@"originalValue"] floatValue];
    _sliderView.minimumValue = [info[@"minimumValue"] floatValue];
    _sliderView.maximumValue = [info[@"maximumValue"] floatValue];
}

#pragma mark - _AlivcLiveBeautifyDetailViewDataSouce
- (NSArray<NSDictionary *> *)itemsOfDetailView:(_AlivcLiveBeautifyDetailView *)detailView {
    return [_detailItems copy];
}

- (void)levelView:(_AlivcLiveBeautifyLevelView *)levelView didChangeLevel:(NSInteger)level {
    _level = level;
    if (self.delegate  && [self.delegate respondsToSelector:@selector(settingsView:didChangeLevel:)]) {
        [self.delegate settingsView:self didChangeLevel:_level];
    }
}

@end
