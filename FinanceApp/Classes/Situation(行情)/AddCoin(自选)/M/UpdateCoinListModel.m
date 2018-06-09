//
//  UpdateCoinListModel.m
//  FinanceApp
//
//  Created by SX on 2018/5/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UpdateCoinListModel.h"

@implementation UpdateCoinListModel

- (void)setMarkets:(NSMutableArray *)markets {
    if (!_markets) {
        _markets = @[].mutableCopy;
    }
}

@end
