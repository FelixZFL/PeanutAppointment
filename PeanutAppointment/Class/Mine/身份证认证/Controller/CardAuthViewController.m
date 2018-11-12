//
//  CardAuthViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/4.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "CardAuthViewController.h"
#import "CardAuthHeadView.h"
#import "MyAccountCell.h"
#import "upYunTool.h"

@interface CardAuthViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) CardAuthHeadView *headView;

@property (nonatomic, assign) NSInteger imageTypeIndex;

@property (nonatomic, strong) UIImage *insideImage;//正面
@property (nonatomic, strong) UIImage *offsideImage;//反面

@property (nonatomic, copy) NSString *insideUrl;//正面
@property (nonatomic, copy) NSString *offsideUrl;//反面

@end

@implementation CardAuthViewController

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

    
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setButtonStateNormalTitle:@"提交" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    submitBtn.backgroundColor = COLOR_UI_THEME_RED;
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_42);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_42);
    }];
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"身份证认证"];
}


#pragma mark - network

- (void)submitRealNameInfo {
    
    NSDictionary *param = @{@"userId":[PATool getUserId],
                            @"username":self.headView.nameTF.text,
                            @"cardNumber":self.headView.cardTF.text,
                            @"zm":self.insideUrl,
                            @"fm":self.offsideUrl
                            };
    [YQNetworking postWithApiNumber:API_NUM_10001 params:param successBlock:^(id response) {
        [SVProgressHUD dismiss];
        if (getResponseIsSuccess(response)) {
            if (self.submitSuccessBlock) {
                self.submitSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - action

- (void)submitBtnAction {
    [self.view endEditing:YES];
    
    if (self.headView.nameTF.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        [self.headView.nameTF becomeFirstResponder];
        return;
    }
    
    if (self.headView.cardTF.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号码"];
        [self.headView.cardTF becomeFirstResponder];
        return;
    }
    if (![self.headView.cardTF.text isHxIdentityCard]) {
        [SVProgressHUD showErrorWithStatus:@"请正确输入身份证号码"];
        [self.headView.cardTF becomeFirstResponder];
        return;
    }
    
    if (!self.insideImage) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证正面照"];
        return;
    }
    if (!self.offsideImage) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证反面照"];
        return;
    }
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [upYunTool upImage:self.insideImage successHandle:^(NSString * _Nonnull url) {
        
        self.insideUrl = url;
        [upYunTool upImage:self.offsideImage successHandle:^(NSString * _Nonnull url) {
            
            self.offsideUrl = url;
            [self submitRealNameInfo];
        } failureHandle:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
        
    } failureHandle:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MyAccountCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [MyAccountCell reuseIdentifier];
    MyAccountCell *cell = (MyAccountCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"手持身份证照正面";
        [cell.nextBtn setTitle:self.insideImage ? @"已选择" : @"选择"];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"手持身份证照反面";
        [cell.nextBtn setTitle:self.offsideImage ? @"已选择" : @"选择"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    NSString *title = @"";
    if (0 == indexPath.row) {
        title = @"手持身份证照正面";
    }else if (1 == indexPath.row) {
        title = @"手持身份证照反面";
    }
    self.imageTypeIndex = indexPath.row;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageWithType:2];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageWithType:1];
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:actionSheet animated:YES completion:nil];
    });
}

#pragma mark - UIImagePickerControllerDelegate - 图片选择回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"选择完毕----image:%@-----info:%@",image,info);
        if (self.imageTypeIndex == 0) {
            self.insideImage = image;
        }else if (self.imageTypeIndex == 1) {
            self.offsideImage = image;
        }
        [self.tableView reloadData];
    }];
    
}


#pragma mark - private
///选择图片的方式 1 相机  2 图片选取
- (void)selectImageWithType:(NSInteger )type
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    imagePickerController.allowsEditing = NO;
    
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
- (CardAuthHeadView *)headView {
    if (!_headView) {
        _headView = [[CardAuthHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [CardAuthHeadView getHeight])];
    }
    return _headView;
}

@end
