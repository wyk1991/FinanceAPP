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
#import "CoinListModel.h"
#import "OptionCoinModel.h"
//自定义一个类型，用于表示列表的展开／缩回状态
typedef NS_ENUM(NSUInteger,MCDropdownListSectionStatu) {
    MCDropdownListSectionStatuOpen = 1,
    MCDropdownListSectionStatuClose = 0,
};

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
    [self.coinListData addObjectsFromArray:arr];
}

- (void)dealCoinAllInfo:(id)result {
    NSArray *tmp;
    if ([result[@"status"] integerValue] == 100) {
        CoinAllInfoModel *model = [CoinAllInfoModel mj_objectWithKeyValues:result];
        tmp = @[
                              @{@"icon_img": @"ic_monetary_aggregates", @"coin_count": [NSString stringWithFormat:@"%@个",model.num_coins], @"title": @"货币总量"},
                              @{@"icon_img": @"ic_arrow_total_value", @"coin_count":[[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"]? model.circulate_money_cny : model.circulate_money_usd, @"title":@"流通总市值"},
                              @{@"icon_img": @"ic_exchange", @"coin_count": [NSString stringWithFormat:@"%@个", model.num_trading_market], @"title": @"交易所"},
                              @{@"icon_img": @"ic_24h", @"coin_count": [[kNSUserDefaults valueForKey:user_currency] isEqualToString:@"cny"] ? model.oneday_money_cny : model.oneday_money_usd, @"title": @"24H交易额"}
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
        [cnyArr addObject:[NSNumber numberWithDouble:[trackM.price_cny doubleValue]]];
        [usdArr addObject:[NSNumber numberWithDouble:[trackM.price_usd doubleValue]]];
        [dateArr addObject:[[MJYUtils mjy_timeChangeWith:trackM.time] substringFromIndex:10]];
    }
//    NSMutableArray *tmp = @[].mutableCopy;
//    for (int i=0; i<dateArr.count; i++) {
//        if (i%2 == 0) { // 偶数
//            [tmp addObject:dateArr[i]];
//        }
//
//    }
    
    [self.chartList addObject:[NSDictionary dictionaryWithObject:cnyArr forKey:@"cny"]];
    [self.chartList addObject:[NSDictionary dictionaryWithObject:usdArr forKey:@"usd"]];
    [self.chartList addObject:[NSDictionary dictionaryWithObject:dateArr forKey:@"time"]];
    for (PricesModel *priceM in model.prices) {
        [self.oneDayList addObject:priceM];
    }
    self.chartCoinList = self.oneDayList.mutableCopy;
    [self.chartCoinList removeObjectAtIndex:0];
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

- (NSMutableArray *)chartCoinList {
    if (!_chartCoinList) {
        _chartCoinList = @[].mutableCopy;
    }
    return _chartCoinList;
}
/**
 获取自选coin列表数据

 @param path path
 @param params params
 @param callback huidiao
 */
- (void)helperGetCoinListNameDataWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:params outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            self.coinNameList = [CoinListModel mj_objectArrayWithKeyValuesArray:retData[@"markets"]];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (NSMutableArray *)coinNameList {
    if (!_coinNameList) {
        _coinNameList = @[].mutableCopy;
    }
    return _coinNameList;
}


/**
    获取自选的列表数据

 @param path path
 @param params params
 @param callback callback
 */
- (void)helperGetOptionCoinListWithPath:(NSString *)path params:(NSDictionary *)params callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:params outParse:^(id retData, NSError *error) {
        
        [weakSelf dealOptionData:retData];
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

- (void)dealOptionData:(id)retData {
    _optionOpenDict = @{}.mutableCopy;
    if ([retData[@"status"] integerValue] == 100) {
        self.optionsCoinList = [OptionCoinModel mj_objectArrayWithKeyValuesArray:retData[@"coinlist"]];
    }
    for (OptionCoinModel *model in self.optionsCoinList) {
        
        [_optionOpenDict setObject:[NSNumber numberWithUnsignedInteger:MCDropdownListSectionStatuClose] forKey:model.market];
    }
}

- (NSMutableArray *)optionsCoinList {
    if (!_optionsCoinList) {
        _optionsCoinList = @[].mutableCopy;
    }
    return _optionsCoinList;
}

- (void)helpDeleteOptionListItemWithPath:(NSString *)path params:(NSDictionary *)params callback:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startPostRequest:path inParam:params outParse:^(id retData, NSError *error) {
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (void)helpAddOptionItemWithPath:(NSString *)path params:(NSString *)str callback:(UICallback)callback {
    WS(weakSelf);
//    [weakSelf startPostRequest:path inParam:str outParse:^(id retData, NSError *error) {
//        callback(retData, nil);
//    } callback:^(id obj, NSError *error) {
//        callback(nil, error);
//    }];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@", Base_URL, path] parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [req setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                //blah blah
                callback(responseObject, nil);
            }
            
        } else {
            
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
    
}


@end
