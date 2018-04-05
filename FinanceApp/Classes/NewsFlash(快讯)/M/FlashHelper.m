//
//  FlashHelper.m
//  FinanceApp
//
//  Created by SX on 2018/3/30.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "FlashHelper.h"
#import "TagsModel.h"
#import "FlashModel.h"
#import "FlashViewModel.h"

@implementation FlashHelper

static FlashHelper *_instance;
- (NSMutableArray *)flashTag {
    if (!_flashTag) {
        _flashTag = @[].mutableCopy;
    }
    return _flashTag;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
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

- (void)helperGetFlashTagWithPath:(NSString *)path callback:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:flash_tag inParam:nil outParse:^(id retData, NSError *error) {
        if (!error) {
            NSArray *arr = retData[@"cate"];
            [weakSelf detalTagWithArr:arr];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil, error);
    }];
}

- (void)detalTagWithArr:(NSArray *)arr {
    if (self.flashTag.count) {
        [self.flashTag removeAllObjects];
    }
    for (NSDictionary *dic in arr) {
        [self.flashTag addObject:[TagsModel mj_objectWithKeyValues:dic]];
    }
}

- (void)helperGetFlashListDataWithPath:(NSString *)path withTags:(NSString *)tagStr callback:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:@{@"cate": tagStr, @"page": @(self.page).stringValue} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealFlashListData:retData];
        }
        callback(retData, error);
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

- (void)dealFlashListData:(id)result {
    NSArray *arr = result[@"kuaixun"];
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    if (arr.count) {
        NSMutableArray *tmp = @[].mutableCopy;
        for (NSDictionary *dic in arr) {
            FlashViewModel *viewModel = [[FlashViewModel alloc] init];
            FlashModel *model = [FlashModel mj_objectWithKeyValues:dic];
            viewModel.model = model;
            [tmp addObject:viewModel];
        }
        [self.dataList addObject:tmp];
    }
    
}

@end
