//
//  DDNewsCache.m
//  FinanceApp
//
//  Created by SX on 2018/3/22.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "DDNewsCache.h"

@implementation DDNewsCache

+ (instancetype)sharedInstance
{
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [NSMutableArray array];
    });
    return _instance;
}

@end
