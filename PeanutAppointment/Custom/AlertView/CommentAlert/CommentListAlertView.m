//
//  CommentListAlertView.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/21.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CommentListAlertView.h"
#import "BaseTableViewCell.h"
#import "CommentToolBar.h"

#import "CommentListModel.h"


@interface CommentListAlertView()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CommentToolBar *toolBar;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) NSString *pusId;

@end


@interface CommentListCell : BaseTableViewCell
@property (nonatomic, strong) CommentListModel *model;
+ (CGFloat)getCellHeightWithModel:(CommentListModel *)model;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@end



@implementation CommentListAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

#pragma mark - UI -
- (void)setupUI {
    
    [self setDefaultCorner];
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(380);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - 70);
    }];
    
    self.toolBar.frame = CGRectMake(0, 380, SCREEN_WIDTH, 70);
    [self addSubview:self.toolBar];
}

#pragma mark - public -

- (void)showInWindow {
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.layerView = [[UIView alloc] init];
    self.layerView.backgroundColor = RGB(0, 0, 0, 0.2);
    [self.layerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removFromWindow)]];
    [window addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [window addSubview:self];
    [self addRefresh];
}

- (void)removFromWindow {
    
    [self.layerView removeFromSuperview];
    [self removeFromSuperview];
}

+ (instancetype )alertWithId:(NSString *)pusId {
    CGFloat height = 380 + HOMEBAR_HEIGHT + 70;
    CommentListAlertView *alert = [[CommentListAlertView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - height, SCREEN_WIDTH, height)];
    alert.pusId = pusId;
    return alert;
}


#pragma mark - refresh -

- (void)addRefresh {
    
    self.pageNum = 0;
    self.pageSize = 10;
    self.dataArr = [NSMutableArray arrayWithCapacity:1];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNum = 0;
        [self.dataArr removeAllObjects];
        [self getData];
        
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        self.pageNum += 1;
        [self getData];
    }];
    
    [self getData];
}

#pragma mark - network -

- (void)getData{
    if (!self.pusId) {
        return;
    }
    [YQNetworking postWithApiNumber:API_NUM_20018 params:@{@"pusId":self.pusId, @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[CommentListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - action -

- (void)sendClickAction {
    if (self.toolBar.textV.text.length < 1) {
        return;
    }
    [self.toolBar endEditing:YES];
    [YQNetworking postWithApiNumber:API_NUM_10016 params:@{@"userId":[PATool getUserId], @"pusId":self.pusId, @"content":self.toolBar.textV.text} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [self.tableView.mj_header beginRefreshing];
        }
    } failBlock:nil];
    self.toolBar.textV.text = @"";
    
}

#pragma mark - 键盘 弹出 收回  通知方法
// 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSValue * aValue = [[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSLog(@"rect===%@",NSStringFromCGRect(keyboardRect));
    [UIView animateWithDuration:[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.toolBar.frame = CGRectMake(0, 380 + HOMEBAR_HEIGHT - keyboardRect.size.height, SCREEN_WIDTH, 70);
        self.toolBar.textV.frame = CGRectMake(MARGIN_15, MARGIN_10, SCREEN_WIDTH - MARGIN_15 * 3 - 75, 50);
        self.toolBar.sendBtn.frame = CGRectMake(SCREEN_WIDTH - MARGIN_15 - 75, MARGIN_10, 75, 50);
    }];
}
// 当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [UIView animateWithDuration:[[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.toolBar.frame = CGRectMake(0, 380, SCREEN_WIDTH, 70);
        self.toolBar.textV.frame = CGRectMake(MARGIN_15, MARGIN_10, SCREEN_WIDTH - MARGIN_15 * 2, 50);
        self.toolBar.sendBtn.frame = CGRectMake(SCREEN_WIDTH - MARGIN_15, MARGIN_10, 0, 50);
    }];
}


#pragma mark - UITextViewDelegate -



#pragma mark - delegate&&datasource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CommentListCell getCellHeightWithModel:self.dataArr[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [CommentListCell reuseIdentifier];
    CommentListCell *cell = (CommentListCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = COLOR_UI_FFFFFF;
    }
    return _tableView;
}

- (CommentToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[CommentToolBar alloc] init];
        _toolBar.textV.delegate = self;
        [_toolBar.sendBtn addTarget:self action:@selector(sendClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBar;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArr;
}


@end






@implementation CommentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI -

- (void)setupUI {
    
    self.backgroundColor = COLOR_UI_FFFFFF;
    
    __weak __typeof(self)weakSelf = self;
    
    [self addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.mas_equalTo(MARGIN_15);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).with.mas_offset(MARGIN_5);
        make.top.equalTo(weakSelf.headImageView.mas_top);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headImageView.mas_right).with.mas_offset(MARGIN_5);
        make.bottom.equalTo(weakSelf.headImageView.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    [self addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.right.mas_equalTo(-MARGIN_15);
        make.top.equalTo(weakSelf.headImageView.mas_bottom).with.mas_offset(MARGIN_15);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
}

#pragma mark - public -

- (void)setModel:(CommentListModel *)model {
    _model = model;

    [self.headImageView sd_setImageWithURL:URLWithString(model.headUrl) placeholderImage:imageNamed(placeHolderHeadImageName)];
    self.nameLabel.text = model.nikeName;
    self.timeLabel.text = model.createTime;
    self.commentLabel.text = model.content;
}

+ (CGFloat)getCellHeightWithModel:(CommentListModel *)model {
    return MARGIN_15 + 45 + MARGIN_15 + [model.content getHeightWithMaxWidth:SCREEN_WIDTH - MARGIN_15 * 2 font:KFont(14)] + MARGIN_25;
}

#pragma mark - getter -

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = imageNamed(placeHolderHeadImageName);
        [_headImageView setCorner:45/2.f];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setLabelFont:KFont(14) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
//        _nameLabel.text = @"张三";
    }
    return _nameLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        [_commentLabel setLabelFont:KFont(14) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentLeft];
        _commentLabel.numberOfLines = 0;
//        _commentLabel.text = @"评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论评论";
    }
    return _commentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setLabelFont:KFont(12) textColor:COLOR_UI_666666 textAlignment:NSTextAlignmentRight];
//        _timeLabel.text = @"今天";
    }
    return _timeLabel;
}


@end

