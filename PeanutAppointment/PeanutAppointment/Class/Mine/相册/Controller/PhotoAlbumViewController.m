//
//  PhotoAlbumViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "PhotoAlbumSectionHeadView.h"
#import "PhotoAlbumCell.h"

#import "PhotoAlbumModel.h"

#import "AddPhotoAlbumViewController.h"
#import "PhotoDetailViewController.h"

@interface PhotoAlbumViewController ()

@end

@implementation PhotoAlbumViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self addRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    UIButton *addPhotoBtn = [[UIButton alloc] init];
    [addPhotoBtn setButtonStateNormalTitle:@"添加相册" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    addPhotoBtn.backgroundColor = COLOR_UI_THEME_RED;
    [addPhotoBtn addTarget:self action:@selector(addPhotoTapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addPhotoBtn];
    [addPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"相册"];
    [self setNavStyle:CustomNavStyle_Light];
}


#pragma mark - refresh -

- (void)addRefresh {
    
    self.pageNum = 0;
    self.pageSize = 10;
    
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

#pragma mark - network

- (void)getData {
    
    //page=1&limit=20
    [YQNetworking postWithApiNumber:API_NUM_20010 params:@{@"userId":[PATool getUserId], @"page":@(self.pageNum * self.pageSize),@"limit":@(self.pageSize)} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[PhotoAlbumModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.tableView reloadData];
        }
        
//        self.placeholderView.hidden = self.dataArr.count > 0;
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - action

- (void)addPhotoTapAction {
    AddPhotoAlbumViewController *vc = [[AddPhotoAlbumViewController alloc] init];
    [vc setAddSuccessBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PhotoAlbumSectionHeadView getHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    NSString *identifier = [PhotoAlbumSectionHeadView reuseIdentifier];
    PhotoAlbumSectionHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(!sectionHeadView){
        sectionHeadView = [[PhotoAlbumSectionHeadView alloc] initWithReuseIdentifier:identifier];
    }
    if (self.dataArr.count > section) {
        PhotoAlbumModel *model = self.dataArr[section];
        sectionHeadView.titleLabel.text = [NSString stringWithFormat:@"%@年",model.years];
    }
    return sectionHeadView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count > section) {
        PhotoAlbumModel *model = self.dataArr[section];
        return model.photos.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArr.count > indexPath.section) {
        PhotoAlbumModel *model = self.dataArr[indexPath.section];
        if (model.photos.count > indexPath.row) {
            return [PhotoAlbumCell getCellHeightWithModel:model.photos[indexPath.row]];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [PhotoAlbumCell reuseIdentifier];
    PhotoAlbumCell *cell = (PhotoAlbumCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PhotoAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setPhotoClickBlock:^(PhotoAlbumPhotosModel * _Nonnull model, NSInteger index) {
            PhotoDetailViewController *vc = [[PhotoDetailViewController alloc] init];
            vc.photoModel = model;
            vc.selectIndex = index;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    if (self.dataArr.count > indexPath.section) {
        PhotoAlbumModel *model = self.dataArr[indexPath.section];
        if (model.photos.count > indexPath.row) {
            [cell setModel:model.photos[indexPath.row]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - getter



@end
