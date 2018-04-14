//
//  SituationHelper.m
//  FinanceApp
//
//  Created by SX on 2018/4/9.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationHelper.h"
#import "CoinAllInfoModel.h"
#import "UnitInfoModel.h"
#import "ChartsDetailModel.h"

@implementation SituationHelper

static SituationHelper *_instance;

- (NSMutableArray *)tagList {
    if (!_tagList) {
        _tagList = @[@"自选", @"库币"].mutableCopy;
    }
    return _tagList;
}

- (NSMutableArray *)coinListData {
    if (!_coinListData) {
        _coinListData = @[].mutableCopy;
    }
    return _coinListData;
}

- (NSMutableArray *)coinInfoData {
    if (!_coinInfoData) {
        _coinInfoData = @[].mutableCopy;
    }
    return _coinInfoData;
}

+ (instancetype)shareHelper {
    
    return  [[self alloc] init];
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            _instance.page = 1;
        }
        return _instance;
    }
    return _instance;
}

- (void)helperGetTagDataWithPath:(NSString *)path callback:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:nil outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            if (self.tagList.count > 2) {
                [self.tagList removeAllObjects];
                [self.tagList addObjectsFromArray:@[@"自选", @"库币"]];
            }
            for (NSDictionary *dic in retData[@"coins"]) {
                NSString *name = dic[@"name"];
                [self.tagList addObject:name];
            }
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil,error);
    }];
}

- (void)heplerGetStockCoinInfo:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:nil outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            
            [weakSelf dealCoinAllInfo:retData];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (void)helperGetListCoinWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback
{
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:@{@"start": [NSString stringWithFormat:@"%ld",(long)self.page]} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealCoinList:retData[@"coins"]];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (void)dealCoinList:(id)result {
    if (self.page == 1) {
        [self.coinListData removeAllObjects];
    }
    
    NSArray *arr = [CoinDetailListModel mj_objectArrayWithKeyValuesArray:result];
    
    self.coinListData = [NSMutableArray arrayWithArray:arr];
}

- (void)dealCoinAllInfo:(id)result {
    NSArray *tmp;
    if ([result[@"status"] integerValue] == 100) {
        CoinAllInfoModel *model = [CoinAllInfoModel mj_objectWithKeyValues:result];
//        NSUserDefaults *defalut = [[NSUserDefaults standardUserDefaults] valueForKey:@"usd_cny"];
#warning 判断当前设置的是美元还是 人民币
        tmp = @[
                              @{@"icon_img": @"ic_monetary_aggregates", @"coin_count": model.num_coins, @"title": @"货币总量"},
                              @{@"icon_img": @"ic_arrow_total_value", @"coin_count": model.circulate_money_cny, @"title":@"流通总市值"},
                              @{@"icon_img": @"ic_exchange", @"coin_count": [NSString stringWithFormat:@"%@个", model.num_trading_market], @"title": @"交易所"},
                              @{@"icon_img": @"ic_24h", @"coin_count": [NSString stringWithFormat:@"%@亿",model.oneday_money_cny], @"title": @"24H交易额"}
                              ];
        NSArray *arr = [UnitInfoModel mj_objectArrayWithKeyValuesArray:tmp];
        self.coinInfoData = [NSMutableArray arrayWithArray:arr];
    }
}


/**
 获取货币详情信息和图表信息

 @param path url
 @param params 参数
 @param callback 回调
 */
- (void)heplerGetCoinDetailWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:params outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealCoinDetal:retData];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (void)dealCoinDetal:(id)result {
    ChartsDetailModel *model = [ChartsDetailModel mj_objectWithKeyValues:result];
    if (self.chartList.count || self.oneDayList.count) {
        [self.chartList removeAllObjects];
        [self.oneDayList removeAllObjects];
    }
    NSMutableArray *cnyArr = @[].mutableCopy;
    NSMutableArray *usdArr = @[].mutableCopy;
    NSMutableArray *dateArr = @[].mutableCopy;
    
    
    for (ChartsTrackModel *trackM in model.oneday_track) {
        [cnyArr addObject:[NSNumber numberWithLong:[trackM.price_cny longLongValue]]];
        [usdArr addObject:[NSNumber numberWithDouble:[trackM.price_usd doubleValue]]];
        [dateArr addObject:[[MJYUtils mjy_timeChangeWith:trackM.time] substringFromIndex:10]];
    }
    [self.chartList addObject:[NSDictionary dictionaryWithObject:cnyArr forKey:@"cny"]];
    [self.chartList addObject:[NSDictionary dictionaryWithObject:usdArr forKey:@"usd"]];
    [self.chartList addObject:[NSDictionary dictionaryWithObject:dateArr forKey:@"time"]];
    for (PricesModel *priceM in model.prices) {
        [self.oneDayList addObject:priceM];
    }
}

- (NSMutableArray *)chartList {
    if (!_chartList) {
        _chartList = @[].mutableCopy;
    }
    return _chartList;
}

- (NSMutableArray *)oneDayList {
    if (!_oneDayList) {
        _oneDayList = @[].mutableCopy;
    }
    return _oneDayList;
}

@end
