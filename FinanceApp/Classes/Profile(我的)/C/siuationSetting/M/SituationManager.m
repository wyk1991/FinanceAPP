//
//  SituationManager.m
//  FinanceApp
//
//  Created by wangyangke on 2018/4/15.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationManager.h"

@implementation SituationManager

+ (NSArray *)getSettingModelWithType:(NSInteger)type {
    NSArray *arr;
    if (type == 0) {
        arr = @[
                 @{@"title": @"路涨红跌", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect": [kNSUserDefaults valueForKey:user_greenRed]},
                 @{@"title": @"红涨绿跌", @"isArrow": @"0",@"isSwitch":@"0",@"isSelect": [kNSUserDefaults valueForKey:user_greenRed] }
                     ];
    } else if (type == 1) {
        arr = @[
                @{@"title": @"CNY多价格", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect": [kNSUserDefaults valueForKey:user_currency]},
                @{@"title":@"USD多价格", @"isArrow":@"0", @"isSwitch": @"0", @"isSelect":[kNSUserDefaults valueForKey:user_currency]}
                ];
    } else {
        arr = @[
                @{@"title": @"声音", @"isArrow":@"0", @"isSwitch": [kNSUserDefaults valueForKey:user_noticeVoiceType]},
                @{@"title": @"震动", @"isArrow":@"0", @"isSwitch": [kNSUserDefaults valueForKey:user_noticeShackType]}
                ];
    }
    return arr;
}

@end
