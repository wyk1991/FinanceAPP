//
//  RollModel.m
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "RollModel.h"

@implementation RollModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"desc" : @"desciption",
             };
}


@end
