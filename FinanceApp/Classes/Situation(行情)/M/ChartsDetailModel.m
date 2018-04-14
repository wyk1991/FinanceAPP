//
//  ChartsDetailModel.m
//  FinanceApp
//
//  Created by SX on 2018/4/13.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "ChartsDetailModel.h"

@implementation ChartsDetailModel

// 这个方法对比上面的2个方法更加没有侵入性和污染
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"oneday_track": @"ChartsTrackModel",
             @"prices": @"PricesModel"
             };
}

@end

@implementation ChartsTrackModel

@end

@implementation PricesModel

@end
