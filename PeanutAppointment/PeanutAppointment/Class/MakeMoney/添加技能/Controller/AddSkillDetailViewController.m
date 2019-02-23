//
//  AddSkillDetailViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/18.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "AddSkillDetailViewController.h"
#import "AddSkillHeadView.h"
#import "upYunTool.h"

#import "SkillDetailModel.h"

#import "AddSkillViewController.h"

@interface AddSkillDetailViewController ()<UITextViewDelegate>

@property (nonatomic, strong) AddSkillHeadView *headView;

@property (nonatomic, strong) UITextView *editingTextV;

@property (nonatomic, strong) NSMutableArray *photoUrlArray;

@end

@implementation AddSkillDetailViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI

- (void)setupUI {
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedAction:)]];
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    self.tableView.tableHeaderView = self.headView;
    self.headView.skillNameLabel.text = self.pasName;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UIButton *releaseBtn = [[UIButton alloc] init];
    [releaseBtn setButtonStateNormalTitle:@"发布技能" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    releaseBtn.backgroundColor = COLOR_UI_THEME_RED;
    [releaseBtn addTarget:self action:@selector(releaseBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:releaseBtn];
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        make.height.mas_equalTo(BUTTON_HEIGHT_50);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
    
    if (_type == AddSkillDetailViewType_edit) {
        [self.headView setModel:self.skillDetail];
    }
    
}

- (void)setupNav {
    [self.customNavBar setTitle:@"添加技能"];
    [self.view bringSubviewToFront:self.customNavBar];
}


#pragma mark - network


#pragma mark - action

- (void)releaseBtnClickAction {
    
    if ([_headView.depositTF.text doubleValue] <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入服务定金"];
        return;
    }
    if ([_headView.depositTF.text doubleValue] <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入服务价格"];
        return;
    }
    if (_headView.serverExperienceTextV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入服务经历"];
        return;
    }
    if (_headView.serverIntroduceTextV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入服务介绍"];
        return;
    }
    if (_headView.personalIntroductionTextV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入个人介绍"];
        return;
    }
    if (_headView.photosArray.count < 1) {
        [SVProgressHUD showErrorWithStatus:@"请上传图片"];
        return;
    }
    
    [SVProgressHUD showWithClearMaskType];
    for (id obj in _headView.photosArray) {
        if ([obj isKindOfClass:[UIImage class]]) {
            [upYunTool upImage:(UIImage *)obj successHandle:^(NSString * _Nonnull url) {
                [self.photoUrlArray addObject:url];
                [self uploadReleaseInfo];
            } failureHandle:^(NSError * _Nonnull error) {
                [SVProgressHUD dismissToMaskTypeNone];
                [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
            }];
        } else {
            [self.photoUrlArray addObject:(NSString *)obj];
            [self uploadReleaseInfo];
        }
    }
}

- (void)uploadReleaseInfo {
    
    if (self.photoUrlArray.count != _headView.photosArray.count) {
        return;
    }
    [SVProgressHUD dismissToMaskTypeNone];
    
    NSString *photosStr = [self.photoUrlArray componentsJoinedByString:@","];
    NSString *serverTiemStr = [_headView.serverDaysArray componentsJoinedByString:@","];
    
    NSDictionary *dic = @{@"userId":[PATool getUserId],@"jnName":_pasName,@"pasId":_pasId, @"serviceType":@(_headView.serverType),@"downPayment":_headView.depositTF.text,@"servicePrice":_headView.priceTF.text, @"unit":@(_headView.PriceUnit), @"serviceTime":serverTiemStr, @"experience":_headView.serverExperienceTextV.text, @"introduce":_headView.serverIntroduceTextV.text, @"photos":photosStr, @"selfIntroduction":_headView.personalIntroductionTextV.text};
    
    NSString *urlStr = @"";
    if (_type == AddSkillDetailViewType_edit) {
        urlStr = API_NUM_10010;
    } else {
        urlStr = API_NUM_10008;
    }
    
    [YQNetworking postWithApiNumber:urlStr params:dic successBlock:^(id response) {
        
        if (getResponseIsSuccess(response)) {
            NSDictionary *dic = getResponseData(response);
            //isOk  0 添加成功  1 已经添加过了此技能
            if ([dic[@"isOk"] integerValue] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"添加成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else if ([dic[@"isOk"] integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:@"您已经添加过了此技能"];
            }
        }
    } failBlock:nil];
    
    /*
     userId：用户id
     jnName：技能名称
     serviceType：服务方式（1:Ta找我 2:我找Ta 3:两个都选）
     downPayment：服务定金
     servicePrice：服务价格
     unit：计价单位（1:次/2:小时）
     serviceTime：服务时间（周一到周末，1代表周一 7代表周末 ，多个日期的时候逗号分隔 比如： serviceTime=1，2，3，4，5）
     experience：服务经历
     introduce：服务介绍
     photos：照片（多张照片逗号分隔 xx.jpg,xx.jpg.....）
     selfIntroduction：个人介绍
     */
    
}

#pragma mark - private -
//点击空白地方收起键盘
- (void)tapGesturedAction:(UIGestureRecognizer *)gesture {
    
    [self.view endEditing:YES];
}

// 当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary * userInfo = [aNotification userInfo];
    NSValue * aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(keyboardRect.size.height));
    }];
    
    NSLog(@"frame == %@",NSStringFromCGRect(self.editingTextV.frame));
}
// 当键盘退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - BUTTON_HEIGHT_50);
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.editingTextV = textView;
    
//    if (textView == self.headView.serverExperienceTextV) {
//
//    } else if (textView == self.headView.serverIntroduceTextV) {
//
//    } else if (textView == self.headView.personalIntroductionTextV) {
//
//    }
    
    return YES;
}

#pragma mark - getter

- (AddSkillHeadView *)headView {
    if (!_headView) {
        _headView = [[AddSkillHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [AddSkillHeadView getHeight])];
        _headView.serverExperienceTextV.delegate = self;
        _headView.serverIntroduceTextV.delegate = self;
        _headView.personalIntroductionTextV.delegate = self;
    }
    return _headView;
}

- (NSMutableArray *)photoUrlArray {
    if (!_photoUrlArray) {
        _photoUrlArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _photoUrlArray;
}

@end
