//
//  MaJiangViewController.m
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/14.
//  Copyright © 2018年 felix. All rights reserved.
//

#import "MaJiangViewController.h"
#import "MaJiangHeadView.h"
#import "MaJiangVipFootView.h"
#import "MaJiangRoomCardFootView.h"

@interface MaJiangViewController ()

@property (nonatomic, strong) MaJiangHeadView *headView;

@property (nonatomic, strong) MaJiangVipFootView *vipFootView;
@property (nonatomic, strong) MaJiangRoomCardFootView *roomCardFootView;

@end

@implementation MaJiangViewController

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
    
    self.view.backgroundColor = self.tableView.backgroundColor = COLOR_UI_FFFFFF;
    
    NSString *contentStr = @"“花生麻将”是由花生约见平台推出的一款娱乐APP，一样的麻将，不一样的精彩玩法";
    NSString *hintStr = @"温馨提醒：花生麻将是一款休闲娱乐游戏，严禁赌博，为了你的健康，请合理安排娱乐时间，最终解释权和版权归APP所有";
    if (_type == MaJiangVCType_RoomCard) {
        hintStr = @"温馨提醒：购买房卡为花生麻将虚拟产品，购买成功后可在花生麻将APP进行娱乐使用，花生麻将是一款休闲娱乐游戏，严禁赌博，为了你的健康，请合理安排娱乐时间，最终解释权和版权归APP所有";
    }
    [self.headView setContentStr:contentStr hintStr:hintStr];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [MaJiangHeadView getHeightWithContentStr:contentStr hintStr:hintStr]);
    self.tableView.tableHeaderView = self.headView;
    
    
    if (_type == MaJiangVCType_Vip) {
        [self.vipFootView setDataArray:@[@"",@"",@"",@""]];
        self.vipFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [MaJiangVipFootView getHeightWithDadaArray:@[@"",@"",@"",@""]]);
        self.tableView.tableFooterView = self.vipFootView;
    } else if (_type == MaJiangVCType_RoomCard) {
        [self.roomCardFootView setDataArray:@[@"",@"",@"",@"",@"",@""]];
        self.roomCardFootView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [MaJiangRoomCardFootView getHeightWithDadaArray:@[@"",@"",@"",@"",@"",@""]]);
        self.tableView.tableFooterView = self.roomCardFootView;
    }
    
    
    if (_type == MaJiangVCType_Main) {
        UIView *btnView = [[UIView alloc] init];
        [self.view addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
            make.bottom.mas_equalTo(-HOMEBAR_HEIGHT);
        }];
        
        CGFloat btnWidth = (SCREEN_WIDTH - MARGIN_15 * 4)/3;
        for (int i = 0; i < 3; i++ ) {
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_15 +  i * (btnWidth + MARGIN_15), 0, btnWidth, 50)];
            [btn setDefaultCorner];
            btn.tag = 555 + i;
            btn.titleLabel.font = KFont(14);
            [btn setborderColor:COLOR_UI_THEME_RED];
            [btn setTitleColor:COLOR_UI_THEME_RED forState:UIControlStateNormal];
            btn.backgroundColor = COLOR_UI_FFFFFF;
            [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [btnView addSubview:btn];
            if (i == 0) {
                [btn setTitle:@"开通vip" forState:UIControlStateNormal];
            } else if (i == 1) {
                [btn setTitle:@"购买房卡" forState:UIControlStateNormal];
            } else if (i == 2) {
                [btn setTitle:@"打开花生麻将" forState:UIControlStateNormal];
                [btn setTitleColor:COLOR_UI_FFFFFF forState:UIControlStateNormal];
                btn.backgroundColor = COLOR_UI_THEME_RED;
            }
        }
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-HOMEBAR_HEIGHT - 60);
        }];
        return;
    }
    
    UIButton *joinBtn = [[UIButton alloc] init];
    [joinBtn setButtonStateNormalTitle:@"进入花生麻将" Font:KFont(14) textColor:COLOR_UI_FFFFFF];
    joinBtn.backgroundColor = COLOR_UI_THEME_RED;
    [joinBtn addTarget:self action:@selector(joinBtnTapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:joinBtn];
    [joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.customNavBar setTitle:@"花生麻将"];
}


#pragma mark - network


#pragma mark - action

- (void)btnClickAction:(UIButton *)sender {
    if (sender.tag - 555 == 0) {
        
        MaJiangViewController *vc = [[MaJiangViewController alloc] init];
        vc.type = MaJiangVCType_Vip;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag - 555 == 1) {
        
        MaJiangViewController *vc = [[MaJiangViewController alloc] init];
        vc.type = MaJiangVCType_RoomCard;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (sender.tag - 555 == 2) {
        
    }
}

- (void)joinBtnTapAction {
    
}

#pragma mark - getter

- (MaJiangHeadView *)headView {
    if (!_headView) {
        _headView = [[MaJiangHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _headView;
}

- (MaJiangVipFootView *)vipFootView {
    if (!_vipFootView) {
        _vipFootView = [[MaJiangVipFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _vipFootView;
}

- (MaJiangRoomCardFootView *)roomCardFootView {
    if (!_roomCardFootView) {
        _roomCardFootView = [[MaJiangRoomCardFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    return _roomCardFootView;
}


@end
