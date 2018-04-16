//
//  SituationManager.m
//  FinanceApp
//
//  Created by SX on 2018/4/14.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "SituationManager.h"

@implementation SituationManager
+ (NSArray *)rightTitleWithType:(NSInteger)showType {
    if (showType == 0) {
        return @[@"最新价", @"涨幅"];
    } else if (showType == 1) {
        return @[@"价格", @"24H涨幅 ▶", @"24H成交额", @"流通市值", @"流通数量", @"成交额", @"流通率", @"发行总量"];
    } else {
        return @[@"最新价", @"涨幅 ▶", @"24小时成交量", @"24小时最高", @"24小时最低"];
    }
}

+ (NSArray *)leftTitleWithType:(NSInteger)showType {
    if (showType == 1) {
        return @[@"#", @"名称"];
    }else  {
        return @[@"名称"];
    }
}
@end
