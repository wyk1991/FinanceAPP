//
//  OptionCoinModel.h
//  FinanceApp
//
//  Created by SX on 2018/4/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionCoinModel : NSObject

@property (nonatomic, copy) NSString *coin_name;
@property (nonatomic, copy) NSString *market;
@property (nonatomic, copy) NSString *oneday_amount;
@property (nonatomic, copy) NSString *oneday_highest_cny;
@property (nonatomic, copy) NSString *oneday_highest_usd;
@property (nonatomic, copy) NSString *oneday_lowest_cny;
@property (nonatomic, copy) NSString *oneday_lowest_usd;

@end
