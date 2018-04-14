//
//  CoinAllInfoModel.h
//  FinanceApp
//
//  Created by SX on 2018/4/9.
//  Copyright © 2018年 wyk. All rights reserved.
//
//"num_coins": 1386, # 货币总量 单位：个
//"circulate_money_cny": "17,595亿",  # 流通总市值 单位：亿人民币
//"circulate_money_usd": "2,809亿",  #  流通总市值 单位：亿美元
//"oneday_money_cny": "1,126亿", # 24H交易额 单位: 亿人民币
//"oneday_money_usd": "178亿", # 24H交易额 单位: 亿美元
//"num_trading_market": 222 # 交易所 单位: 个
#import <Foundation/Foundation.h>

@class CoinDetailListModel;
@interface CoinAllInfoModel : NSObject

@property (nonatomic, copy) NSString *num_coins;
@property (nonatomic, copy) NSString *circulate_money_cny;
@property (nonatomic, copy) NSString *circulate_money_usd;
@property (nonatomic, copy) NSString *oneday_money_cny;
@property (nonatomic, copy) NSString *oneday_money_usd;
@property (nonatomic, copy) NSString *num_trading_market;

//@property (nonatomic, strong) NSMutableArray<CoinDetailListModel *> *coins;
@end

//"oneday_change": 5.43, #, 24H涨幅
//"oneday_increase": 1, # 1: 24H涨，0：24H跌
//"oneday_money_cny": "541.01亿", #  24H成交额
//"circulate_money": "7,966.86亿", # 流通市值
//"circulate_amount", "1,696万" # 流通数量
//"circulate_percentage": 80.75, # 流通率
//"total_amount": "2,100万", # 流通率
@interface CoinDetailListModel: NSObject

@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *logo_url;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *oneday_change;
@property (nonatomic, copy) NSString *oneday_increase;
@property (nonatomic, copy) NSString *oneday_money_cny;
@property (nonatomic, copy) NSString *circulate_money;
@property (nonatomic, copy) NSString *circulate_amount;
@property (nonatomic, copy) NSString *circulate_percentage;
@property (nonatomic, copy) NSString *total_amount;


@end
