//
//  ChartsDetailModel.h
//  FinanceApp
//
//  Created by SX on 2018/4/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChartsTrackModel, PricesModel;
@interface ChartsDetailModel : NSObject

@property (nonatomic, strong) NSArray<ChartsTrackModel*> *oneday_track;
@property (nonatomic, strong) NSArray<PricesModel*> *prices;


@end


@interface ChartsTrackModel: NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *price_usd;
@property (nonatomic, copy) NSString *price_cny;
@end

//"trading_market_name": "Huobi", # 交易所名称
//"price_cny": "45,937.97", # 最新价
//"price_usd": "7,309.29",
//"change": 1.12, # 涨幅
//"increase": 0, # 1： 涨，0：跌
//"oneday_amount": "2.08万", # 24H成交量
//"oneday_highest_cny": "47,173.5", # 24H最高
//"oneday_lowest_cny": "44,277.61", # 24H最低
//"oneday_highest_usd": "7,500", # 24H最低
//"oneday_lowest_usd": "7,039.59", # 24H最低
@interface PricesModel: NSObject
@property (nonatomic, copy) NSString *trading_market_name;
@property (nonatomic, copy) NSString *price_cny;
@property (nonatomic, copy) NSString *price_usd;
@property (nonatomic, copy) NSString *change;
@property (nonatomic, copy) NSString *increase;
@property (nonatomic, copy) NSString *oneday_amount;
@property (nonatomic, copy) NSString *oneday_highest_cny;
@property (nonatomic, copy) NSString *oneday_lowest_cny;
@property (nonatomic, copy) NSString *oneday_highest_usd;
@property (nonatomic, copy) NSString *oneday_lowest_usd;
@end
