//
//  AddPhotoAlbumViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/7.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddPhotoAlbumViewController.h"
#import "AddPhotoAlbumHeadView.h"
#import "AddPhotoAlbumFootView.h"
#import "upYunTool.h"

#import "PhotoTypeListModel.h"


@interface AddPhotoAlbumViewController ()

@property (nonatomic, strong) AddPhotoAlbumHeadView *headView;
@property (nonatomic, strong) AddPhotoAlbumFootView *footView;

@property (nonatomic, strong) NSMutableArray *photoUrlArray;

@end

@implementation AddPhotoAlbumViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableFooterView = self.footView;
    
    
    UIButton *addSkillBtn = [[UIButton alloc] init];
    [addSkillBtn setButtonStateNormalTitle:@"添加照片" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    addSkillBtn.backgroundColor = COLOR_UI_THEME_RED;
    [addSkillBtn addTarget:self action:@selector(addSkillBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addSkillBtn];
    [addSkillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.customNavBar setTitle:@"添加相册"];
}


#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20031 params:@{@"userId":[PATool getUserId]} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            NSArray *array = [PhotoTypeListModel mj_objectArrayWithKeyValuesArray:getResponseData(response)];
            self.headView.frame = CGRectMake(0, 0, ScreenWidth, [AddPhotoAlbumHeadView getHeightwithArray:array]);
            [self.headView setTagArray:array];
            self.tableView.tableHeaderView = self.headView;
        }
    } failBlock:^(NSError *error) {
    }];
}


#pragma mark - action

- (void)addSkillBtnAction {
    NSString *typeId = nil;
    if (self.headView.tagArray.count > self.headView.tagView.selectedTagIndex) {
        PhotoTypeListModel *model = self.headView.tagArray[self.headView.tagView.selectedTagIndex];
        typeId = model.ptId;
    }
    if (typeId == nil) {
        [SVProgressHUD showErrorWithStatus:@"请先选择类型"];
        return;
    }
    if (self.footView.photos.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请先添加图片"];
        return;
    }
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    for (UIImage *image in self.footView.photos) {
        [upYunTool upImage:image successHandle:^(NSString * _Nonnull url) {
            [self.photoUrlArray addObject:url];
            [self requestAddPhotoWithTypeId:typeId];
        } failureHandle:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
        }];
    }

}

- (void)requestAddPhotoWithTypeId:(NSString *)typeId {
    if (self.photoUrlArray.count != _footView.photos.count) {
        return;
    }
    
    NSString *photosStr = [self.photoUrlArray componentsJoinedByString:@","];
    [YQNetworking postWithApiNumber:API_NUM_10025 params:@{@"userId":[PATool getUserId], @"typeId":typeId, @"photosUrl":photosStr} successBlock:^(id response) {
        [SVProgressHUD dismiss];
        if (getResponseIsSuccess(response)) {
            [SVProgressHUD showSuccessWithStatus:@"添加相册成功"];
            if (self.addSuccessBlock) {
                self.addSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - getter

- (AddPhotoAlbumHeadView *)headView {
    if (!_headView) {
        _headView = [[AddPhotoAlbumHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AddPhotoAlbumHeadView getHeightwithArray:@[]])];
    }
    return _headView;
}

- (AddPhotoAlbumFootView *)footView {
    if (!_footView) {
        __weak __typeof(self)weakSelf = self;
        _footView = [[AddPhotoAlbumFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AddPhotoAlbumFootView getHeight])];
        [_footView setHeightChangeBlock:^(CGFloat height) {
            weakSelf.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            weakSelf.tableView.tableHeaderView = weakSelf.footView;
        }];
    }
    return _footView;
}

- (NSMutableArray *)photoUrlArray {
    if (!_photoUrlArray) {
        _photoUrlArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _photoUrlArray;
}

@end
