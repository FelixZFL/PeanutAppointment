//
//  MyInfoViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoHeadView.h"
#import "MyInfoCell.h"

#import "UserInfoModel.h"

#import "upYunTool.h"

@interface MyInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) MyInfoHeadView *headView;
@property (nonatomic, strong) MyInfoCell *cell;

@end

@implementation MyInfoViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    self.tableView.tableHeaderView = self.headView;
    [self.headView updateWithModel:self.model];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"个人信息"];
    __weak __typeof(self)weakSelf = self;
    [self.customNavBar setRightButtonWithTitle:@"保存" titleColor:COLOR_UI_FFFFFF];
    [self.customNavBar setOnClickRightButton:^(UIButton *btn) {
        if (![weakSelf.cell.nickNameTF.text isEqual:weakSelf.model.nikeName]) {
            [weakSelf requestChangeUserInfo];
        }
    }];
}


#pragma mark - network

- (void)requestChangeUserInfo {
    if (self.cell.nickNameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
        return;
    }
    [self.view endEditing:YES];
    [YQNetworking postWithApiNumber:API_NUM_10011 params:@{@"userId":[PATool getUserId],@"nikeName":self.cell.nickNameTF.text} successBlock:^(id response) {
        if (getResponseIsSuccess(response)) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        }
    } failBlock:nil];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyInfoCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [MyInfoCell reuseIdentifier];
    MyInfoCell *cell = (MyInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell updateWithModel:self.model];
    }
    self.cell = cell;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - action

- (void)headViewTapAction {
    [self choosePhotoType];
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
                if (getResponseIsSuccess(response)) {
                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                    self.headView.headImageV.image = image;
                }
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

#pragma mark - getter
- (MyInfoHeadView *)headView {
    if (!_headView) {
        _headView = [[MyInfoHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [MyInfoHeadView getHeight])];
        [_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTapAction)]];
    }
    return _headView;
}

@end
