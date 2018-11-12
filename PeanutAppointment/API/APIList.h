//
//  APIList.h
//  PeanutAppointment
//
//  Created by zfl－mac on 2018/10/3.
//  Copyright © 2018年 felix. All rights reserved.
//

#ifndef APIList_h
#define APIList_h

#import "YQNetworking.h"

#define APIOnline  0

#if APIOnline

static NSString * const BaseURL = @"http://www.xxxx.com";//正式

#else

//static NSString * const BaseURL = @"http://192.168.1.104:8080";//本地
static NSString * const BaseURL = @"http://39.107.76.196:8080";//测试

#endif


static NSString * const APITypeQuery = @"/appQuery/query";
static NSString * const APITypeWrite = @"/appWrite/write";



//获取Sts信息接口（用于视频上传/直播开启）
static NSString * const API_NUM_20023 = @"20023";//

//个人中心-返利排行榜接口
static NSString * const API_NUM_20001 = @"20001";//

//个人中心-我的花生米接口
static NSString * const API_NUM_20002 = @"20002";//

//个人中心-会员接口
static NSString * const API_NUM_20003 = @"20003";//

//个人中心-账户接口
static NSString * const API_NUM_20004 = @"20004";//

//个人中心-账户-账单接口
static NSString * const API_NUM_20005 = @"20005";//

//个人中心-账户-身份认证接口
static NSString * const API_NUM_10001 = @"10001";//

//个人中心-账户-修改提现密码/设置提现密码接口
static NSString * const API_NUM_10002 = @"10002";//

//个人中心-账户-提现接口
static NSString * const API_NUM_10003 = @"10003";//

//个人中心-账户-充值接口
static NSString * const API_NUM_10004 = @"10004";//

//个人中心-积分兑换（查询）接口
static NSString * const API_NUM_20006 = @"20006";//

//个人中心接口
static NSString * const API_NUM_20007 = @"20007";//

//个人中心-我的打赏接口
static NSString * const API_NUM_20008 = @"20008";//

//个人中心-我的主页接口
static NSString * const API_NUM_20009 = @"20009";//

//个人中心-我的相册接口
static NSString * const API_NUM_20010 = @"20010";//

//个人中心-个人认证接口
static NSString * const API_NUM_20011 = @"20011";//

//个人中心-设置-建议与反馈接口
static NSString * const API_NUM_10006 = @"10006";//

//关于app及规则
static NSString * const API_NUM_20012 = @"20012";//

//APP首页底部-去约单接口
static NSString * const API_NUM_20013 = @"20013";//

//APP首页底部-去约单-获取用户接口
static NSString * const API_NUM_20014 = @"20014";//

//APP首页底部-去赚钱接口
static NSString * const API_NUM_20015 = @"20015";//

//APP首页底部-去赚钱-发布技能接口
static NSString * const API_NUM_10008 = @"10008";//

//APP首页底部-去赚钱-删除技能接口
static NSString * const API_NUM_10009 = @"10009";//

//APP首页底部-去赚钱-修改技能接口
static NSString * const API_NUM_10010 = @"10010";

//APP首页底部-去赚钱-上传头像接口：（注：所有修改和上传头像接口通用）
static NSString * const API_NUM_10011 = @"10011";//

//注册接口（点击微信登录后）
static NSString * const API_NUM_10012 = @"10012";//

//获取验证码接口
static NSString * const API_NUM_20016 = @"20016";//

//微信登陆（验证手机号接口）
static NSString * const API_NUM_10013 = @"10013";//

//APP首页接口
static NSString * const API_NUM_20017 = @"20017";//

//个人中心-会员-开通会员接口
static NSString * const API_NUM_10014 = @"10014";//

//APP首页 -点赞接口
static NSString * const API_NUM_10015 = @"10015";//

//APP首页-评论接口
static NSString * const API_NUM_10016 = @"10016";//

//APP首页-获取评论list接口
static NSString * const API_NUM_20018 = @"20018";//

//APP右上角消息接口
static NSString * const API_NUM_20024 = @"20024";//

//APP首页-分类查询接口
static NSString * const API_NUM_20022 = @"20022";/////!!!

//APP首页-去赚钱-上传视频/开启直播接口
static NSString * const API_NUM_10017 = @"10017";

//APP首页-今日达人列表接口
static NSString * const API_NUM_20025 = @"20025";//

//APP首页-订单管理-需求管理接口
static NSString * const API_NUM_20026 = @"20026";/////!!!

//APP首页-订单管理-接单中接口：
static NSString * const API_NUM_20027 = @"20027";/////!!!

//APP首页-订单管理-已完成接口
static NSString * const API_NUM_20028 = @"20028";/////!!!

//APP首页-订单管理-已完成-评价接口（调用之前的技能评论接口，本身是对技能进行评价的）

//APP首页-订单管理-删除订单
static NSString * const API_NUM_10018 = @"10018";/////!!!

//APP首页-订单管理-订单中-应邀赚钱接口
static NSString * const API_NUM_10019 = @"10019";

//APP首页-订单管理-需求管理-查看应邀者信息接口
static NSString * const API_NUM_20029 = @"20029";

//支付定金接口：
static NSString * const API_NUM_10020 = @"10020";

//APP首页-打赏-礼物查询接口
static NSString * const API_NUM_20030 = @"20030";//礼物缺图片 

//APP首页-打赏接口
static NSString * const API_NUM_10021 = @"10021";//

//APP首页-打赏-金砖充值接口
static NSString * const API_NUM_10022 = @"10022";//缺少金钻数据id

//APP首页-分享
static NSString * const API_NUM_10023 = @"10023";//

//APP首页-用户签到
static NSString * const API_NUM_10024 = @"10024";//

//个人中心-我的相册-添加相册-类型查询接口
static NSString * const API_NUM_20031 = @"20031";//

//个人中心-我的相册-添加相册接口
static NSString * const API_NUM_10025 = @"10025";/////!!!

//APP首页-查看别人主页接口
static NSString * const API_NUM_20032 = @"20032";

//APP首页-查看别人主页-选择不同的技能返回不通的技能信息接口
static NSString * const API_NUM_20033 = @"20033";

//APP首页-游戏-开通VIP查询接口
static NSString * const API_NUM_20034 = @"20034";

//APP首页-游戏-开通VIP接口
static NSString * const API_NUM_10026 = @"10026";

//APP首页-游戏-购买房卡查询
static NSString * const API_NUM_20035 = @"20035";

//APP首页-游戏-购买房卡接口
static NSString * const API_NUM_10027 = @"10027";

//用户技能查询接口：（通过用户id获取用户的所有技能，此接口用于在约单个用户的时候 在发布需求界面会用到，如果是从APP首页--》〉去约单--》〉在发布需求界面的技能就直接从去约单里面带过去。）
static NSString * const API_NUM_20036 = @"20036";

//APP首页筛选接口
static NSString * const API_NUM_20021 = @"20021";

//视频/直播 播放次数添加接口：（注：用户在播放视频/直播的时候调用）
static NSString * const API_NUM_10028 = @"10028";

//视频/直播 评论添加接口：（注：用户在播放视频/直播 进行评论的时候调用）
static NSString * const API_NUM_10029 = @"10029";

// APP首页-获取视频/直播评论list接口：
static NSString * const API_NUM_20037 = @"20037";

//关闭直播接口
static NSString * const API_NUM_10030 = @"10030";

//创建直播间接口：
static NSString * const API_NUM_10031 = @"10031";

//删除直播间接口
static NSString * const API_NUM_10032 = @"10032";





//
//static NSString * const API_NUM_10030 = @"10030";

//
//static NSString * const API_NUM_20030 = @"20030";


#endif /* APIList_h */
