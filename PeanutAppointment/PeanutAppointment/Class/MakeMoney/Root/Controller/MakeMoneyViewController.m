//
//  MakeMoneyViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/9/10.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MakeMoneyViewController.h"
#import "MakeMoneyHeadView.h"
#import "MakeMoneySkillCell.h"
#import "VideoTypeAlertView.h"

#import "MakeMoneySkillModel.h"

#import "upYunTool.h"

#import "AddSkillViewController.h"//添加技能
#import "PersonalAuthViewController.h"//个人认证
#import "PhotoAlbumViewController.h"//相册

//module
#import "AliyunMediator.h"
#import "AlivcProfile.h"
#import "AliyunMediaConfig.h"
#import "AliyunIConfig.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "AlivcHomeViewController.h"
#import "AlivcLivePlayViewController.h"
#import "MBProgressHUD+AlivcHelper.h"

@interface MakeMoneyViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) MakeMoneyHeadView *headView;

@property (assign, nonatomic) BOOL isPhotoToRecord;
@property (assign, nonatomic) BOOL isUnActive;
@end

@implementation MakeMoneyViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
    
    [self getData];
    
    [self addNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    [self setupSDKUI];
    
    self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableHeaderView = self.headView;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TABBAR_HEIGHT);
    }];
}

- (void)setupNav {
    [self.customNavBar setTitle:@"添加技能"];
}

#pragma mark - network

- (void)getData {
    
    [YQNetworking postWithApiNumber:API_NUM_20015 params:@{@"userId":[PATool getUserId]} successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            [self.dataArr addObjectsFromArray:[MakeMoneySkillModel mj_objectArrayWithKeyValuesArray:getResponseData(response)]];
            [self.tableView reloadData];
        }
    } failBlock:^(NSError *error) {
    }];
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = COLOR_UI_FFFFFF;
    
    UILabel *label = [UILabel labelWithFont:KFont(17) textColor:COLOR_UI_222222 textAlignment:NSTextAlignmentLeft];
    label.text = @"我的技能";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_15);
        make.top.bottom.right.mas_equalTo(0);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = COLOR_UI_F0F0F0;
    [view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MakeMoneySkillCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [MakeMoneySkillCell reuseIdentifier];
    MakeMoneySkillCell *cell = (MakeMoneySkillCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MakeMoneySkillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setEditBlock:^(MakeMoneySkillModel * _Nonnull model) {
            [YQNetworking postWithApiNumber:API_NUM_10009 params:@{@"userId":[PATool getUserId],@"id":model.ID} successBlock:^(id response) {
                if (getResponseIsSuccess(response)) {
                    [self getData];
                }
            } failBlock:nil];
        }];
        [cell setDeleteBlock:^(MakeMoneySkillModel * _Nonnull model) {
            
        }];
    }
    if (self.dataArr.count > indexPath.row) {
        [cell setModel:self.dataArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - UIImagePickerControllerDelegate - 图片选择回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"选择完毕----image:%@-----info:%@",image,info);
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [upYunTool upImage:image successHandle:^(NSString * _Nonnull url) {
            [SVProgressHUD dismiss];
            [YQNetworking postWithApiNumber:API_NUM_10011 params:@{@"userId":[PATool getUserId],@"headUrl":url} successBlock:^(id response) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            } failBlock:nil];
            
        } failureHandle:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
        
    }];
    
}

#pragma mark - private
///上传头像方式
- (void)choosePhotoType {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"上传头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageWithType:2];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageWithType:1];
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:sheet animated:YES completion:nil];
    });
}

///选择图片的方式 1 相机  2 图片选取
- (void)selectImageWithType:(NSInteger )type
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePickerController.allowsEditing = YES;
    
    if (type == 1) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置摄像头模式（拍照，录制视频）为录像模式
        imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Notification
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)appWillResignActive:(id)sender{
    self.isUnActive = YES;
}
- (void)appDidBecomeActive:(id)sender{
    self.isUnActive = NO;
}

- (void)setupSDKUI {
    
    AliyunIConfig *config = [[AliyunIConfig alloc] init];
    
    config.backgroundColor = RGBToColor(35, 42, 66);
    config.timelineBackgroundCollor = RGBToColor(35, 42, 66);
    config.timelineDeleteColor = [UIColor redColor];
    config.timelineTintColor = RGBToColor(239, 75, 129);
    config.durationLabelTextColor = [UIColor redColor];
    config.hiddenDurationLabel = NO;
    config.hiddenFlashButton = NO;
    config.hiddenBeautyButton = NO;
    config.hiddenCameraButton = NO;
    config.hiddenImportButton = NO;
    config.hiddenDeleteButton = NO;
    config.hiddenFinishButton = NO;
    config.recordOnePart = NO;
    config.filterArray = @[@"filter/炽黄",@"filter/粉桃",@"filter/海蓝",@"filter/红润",@"filter/灰白",@"filter/经典",@"filter/麦茶",@"filter/浓烈",@"filter/柔柔",@"filter/闪耀",@"filter/鲜果",@"filter/雪梨",@"filter/阳光",@"filter/优雅",@"filter/朝阳",@"filter/波普",@"filter/光圈",@"filter/海盐",@"filter/黑白",@"filter/胶片",@"filter/焦黄",@"filter/蓝调",@"filter/迷糊",@"filter/思念",@"filter/素描",@"filter/鱼眼",@"filter/马赛克",@"filter/模糊"];
    config.imageBundleName = @"QPSDK";
    config.recordType = AliyunIRecordActionTypeCombination;
    config.filterBundleName = nil;
    config.showCameraButton = YES;
    
    [AliyunIConfig setConfig:config];
}


- (void)toRecordVideoVC {
    AliyunMediaConfig *quVideo = [[AliyunMediaConfig alloc] init];
    quVideo.outputSize = CGSizeMake(540, 720);
    quVideo.minDuration = 2;
    quVideo.maxDuration = 30;
    CGFloat width = 540;
    CGFloat height = ceilf(540 / 0.75); // 视频的videoSize需为整偶数
    quVideo.outputSize = CGSizeMake(width, height);
    NSLog(@"videoSize:w:%f  h:%f", quVideo.outputSize.width, quVideo.outputSize.height);
    UIViewController *recordVC = [[AliyunMediator shared] recordViewController];
    [recordVC setValue:self forKey:@"delegate"];
    [recordVC setValue:quVideo forKey:@"quVideo"];
    [recordVC setValue:@(YES) forKey:@"isSkipEditVC"];
    [self.navigationController pushViewController:recordVC animated:YES];
    
//    [[AliyunMediator shared] pushWithModuleString:AliyunShortVideoModuleString_VideoShooting nav:self.navigationController];
}


#pragma mark - RecordViewControllerDelegate
- (void)exitRecord {
    if (self.isPhotoToRecord) {
        self.isPhotoToRecord = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)recoderFinish:(UIViewController *)vc videopath:(NSString *)videoPath {
    
    if (self.isPhotoToRecord) {
        self.isPhotoToRecord = NO;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:videoPath] completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"录制完成，保存到相册失败");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
        return;
    }
    UIViewController *editVC = [[AliyunMediator shared] editViewController];
    NSString *outputPath = [[vc valueForKey:@"recorder"] valueForKey:@"taskPath"];
    [editVC setValue:outputPath forKey:@"taskPath"];
    [editVC setValue:[vc valueForKey:@"quVideo"] forKey:@"config"];
    
    if (!_isUnActive) {
        [self.navigationController pushViewController:editVC animated:YES];
    }
}


- (void)recordViewShowLibrary:(UIViewController *)vc {
#if SDK_VERSION != SDK_VERSION_BASE
    [AliyunIConfig config].showCameraButton = NO;
#endif
    UIViewController *compositionVC = [[AliyunMediator shared] compositionViewController];
    AliyunMediaConfig *mediaConfig = [[AliyunMediaConfig alloc] init];
    mediaConfig.fps = 25;
    mediaConfig.gop = 5;
    mediaConfig.videoQuality = 1;
    mediaConfig.cutMode = AliyunMediaCutModeScaleAspectFill;
    mediaConfig.encodeMode = AliyunEncodeModeHardH264;
    mediaConfig.outputSize = CGSizeMake(540, 720);
    mediaConfig.videoOnly = NO;
    [compositionVC setValue:mediaConfig forKey:@"compositionConfig"];
    [self.navigationController pushViewController:compositionVC animated:YES];
    
}

- (void)toLivePlayVC {
    AlivcLivePlayViewController *targetVC = [[AlivcLivePlayViewController alloc]init];
    [targetVC setShowedCompletion:^(NSString *errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showMessage:errorStr inView:self.view];
        });
    }];
    targetVC.role = AlivcLiveRoleHost;
    
    AlivcUser *userInfo = [[AlivcUser alloc]init];
    userInfo.userId = [AlivcProfile shareInstance].userId;
    userInfo.userDesp = [AlivcProfile shareInstance].nickname;
    targetVC.userInfo = userInfo;
    
    AlivcInteractiveLiveRoomConfig *roomConfig = [[AlivcInteractiveLiveRoomConfig alloc]init];
    roomConfig.beautyOn = true;
    roomConfig.beautyMode = AlivcBeautyPressional;
    roomConfig.resolution = AlivcLivePushResolution540P;
    // roomConfig.playUrlType = AlivcLivePlayUrlRtmpHD;
    // roomConfig.reportLikeInterval = 5 * 1000;
    roomConfig.pauseImg = [UIImage imageNamed:@"alivcReources.bundle/background_push"];
    targetVC.roomConfig = roomConfig;
    
    [self.navigationController pushViewController:targetVC animated:YES];
}

#pragma mark - getter

- (MakeMoneyHeadView *)headView {
    if (!_headView) {
        __weak __typeof(self)weakSelf = self;
        _headView = [[MakeMoneyHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [MakeMoneyHeadView getHeight])];
        [_headView setButtonClickBlock:^(NSInteger index) {
            // @[@"添加技能",@"上传视频",@"个人认证",@"上传相册",@"上传头像"];
            if (index == 0) {
                AddSkillViewController *vc = [[AddSkillViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else if (index == 1) {
                //@[@"视频拍摄",@"互动直播"];
                [[VideoTypeAlertView alertWithBlock:^(NSInteger index) {
                    if (index == 0) {
                        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"视频选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                        [sheet addAction:[UIAlertAction actionWithTitle:@"拍摄视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [weakSelf toRecordVideoVC];
                        }]];
                        [sheet addAction:[UIAlertAction actionWithTitle:@"选择视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [weakSelf recordViewShowLibrary:weakSelf];
                        }]];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf presentViewController:sheet animated:YES completion:nil];
                        });
                    } else if (index == 1) {//互动直播
                        [weakSelf toLivePlayVC];
                    }
                }] showInWindow];
            } else if (index == 2) {
                PersonalAuthViewController *vc = [[PersonalAuthViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else if (index == 3) {
                PhotoAlbumViewController *vc = [[PhotoAlbumViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else if (index == 4) {
                [weakSelf choosePhotoType];
            }
        }];
    }
    return _headView;
}

@end
