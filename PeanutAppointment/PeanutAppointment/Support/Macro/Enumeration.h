//
//  Enumeration.h
//  ainonggu
//
//  Created by zfl－mac on 2018/8/29.
//  Copyright © 2018年 felix. All rights reserved.
//

#ifndef Enumeration_h
#define Enumeration_h


///商品类型  KJ表示快捷区产品  XF 消费积分专区   BI 农合链抵扣专区
///KJ表示快捷区产品
static NSString * const enumer_COMMODITY_TYPE_KJ = @"KJ";
///XF 消费积分专区
static NSString * const enumer_COMMODITY_TYPE_XF = @"XF";
///BI 农合链抵扣专区
static NSString * const enumer_COMMODITY_TYPE_BI = @"BI";

///订单状态
///订单状态---等待买家付款
static NSString * const enumer_ORDER_STATE_SUBMITTED = @"SUBMITTED";
///订单状态---已付款
static NSString * const enumer_ORDER_STATE_PAID = @"PAID";
///订单状态---已发货，待收货
static NSString * const enumer_ORDER_STATE_SHIPPING = @"SHIPPING";
///订单状态---完成，已签收
static NSString * const enumer_ORDER_STATE_COMPLETED = @"COMPLETED";
///订单状态---交易关闭
static NSString * const enumer_ORDER_STATE_TRADE_CLOSE = @"TRADE_CLOSE";
///订单状态---待评价
static NSString * const enumer_ORDER_STATE_EVALUATE = @"EVALUATE";
///订单状态---申请取消
static NSString * const enumer_ORDER_STATE_CANCELLED = @"CANCELLED";


///委托状态  PENDING  等待成交，已挂单   PENDED 已经成交 CANCEL 撤销
///等待成交，已挂单
static NSString * const enumer_PENDING = @"PENDING";
///已经成交
static NSString * const enumer_PENDED = @"PENDED";
///撤销
static NSString * const enumer_CANCEL = @"CANCEL";



///委托类型 卖出    type枚举：BUY,SELL
static NSString * const enumer_TYPE_SELL = @"SELL";
///委托类型 买入
static NSString * const enumer_TYPE_BUY = @"BUY";



///用户类型  leader  合伙人。 gd 高级合伙人。 guest 普通用户
static NSString * const enumer_USET_TYPE_LEADER = @"leader";
///用户类型  gd 高级合伙人
static NSString * const enumer_USET_TYPE_GD = @"gd";
///用户类型  guest 普通用户
static NSString * const enumer_USET_TYPE_GUEST = @"guest";




#endif /* Enumeration_h */
