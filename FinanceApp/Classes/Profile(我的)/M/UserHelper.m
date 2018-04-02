//
//  UserHelper.m
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

static UserHelper *_instance;

+ (instancetype)shareHelper {
    
    return  [[self alloc] init];
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
        return _instance;
    }
    return _instance;
}


@end
