//
//  HomeHelper.m
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "HomeHelper.h"
#import "RollModel.h"
#import "TagsModel.h"

@implementation HomeHelper

static HomeHelper *_instance;

- (NSMutableArray *)AdModelArr {
    if (!_AdModelArr) {
        _AdModelArr = @[].mutableCopy;
    }
    return _AdModelArr;
}

- (NSMutableArray *)tagArr {
    if (!_tagArr) {
        _tagArr = @[].mutableCopy;
    }
    return _tagArr;
}

- (NSMutableArray *)unSelectTagArr {
    if (!_unSelectTagArr) {
        _unSelectTagArr = @[].mutableCopy;
    }
    return _unSelectTagArr;
}

- (NSMutableArray *)tagList {
    if (!_tagList) {
        _tagList = @[].mutableCopy;
    }
    return _tagList;
}

- (NSMutableArray *)scrollList {
    if (!_scrollList) {
        _scrollList = @[].mutableCopy;
    }
    return _scrollList;
}

- (NSMutableArray *)dateList {
    if (!_dateList) {
        _dateList = @[].mutableCopy;
    }
    return _dateList;
}

- (NSMutableArray *)contentArr {
    if (!_contentArr) {
        _contentArr = @[].mutableCopy;
    }
    return _contentArr;
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

- (void)helperGetTagDataFromPath:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
//    [self startGETRequest:path inParam:nil outParse:^(id retData, NSError *error) {
//        if ([retData[@"status"] integerValue] == 100) {
//            [weakSelf dealTagWith:retData];
//        }
//
//        callback(retData, error);
//    } callback:^(id obj, NSError *error) {
//        callback(nil, error);
//    }];
    
    [HttpTool getRequestCacheURLStr:tag_list dataField:@"categories" inParam:nil outParse:^(id retData, NSError *error) {
        
    } callback:^(id obj, NSError *error) {
        [weakSelf dealTagWith:obj];
        
        callback(obj, error);
    }];
}

- (void)dealTagWith:(id)result {
        for (NSDictionary *dic in result) {
            [self.tagList addObject:dic[@"name"]];
            
            [self.tagArr addObject:dic];
        
    }
}

- (void)helperGetScrollDataWithPath:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:nil outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealScrollImgData:retData];
        }
        callback(retData, error);
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

- (void)dealScrollImgData:(id)result {
    NSArray *arr = result[@"articles"];
    if (arr.count) {
        self.scrollList = [RollModel mj_keyValuesArrayWithObjectArray:arr];
    }
}

- (void)helperGetMiddleData:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:nil outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf detalAdModel:retData];
        }
        callback(retData, error);
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

-  (void)detalAdModel:(id)result {
    NSArray *arr = result[@"articles"];
    if (arr.count) {
        for (NSDictionary *dic in arr) {
            [self.AdModelArr addObject:[NewsModel mj_objectWithKeyValues:dic]];
            [self.contentArr addObject:dic[@"title"]];
        }
    }
}

- (void)helperGetDataListWithPath:(NSString *)path WithTag:(NSString *)tag callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:@{@"cate": tag, @"page": @(self.page).stringValue} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealDataList:retData];
        }
        callback(retData, error);
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

- (void)dealDataList:(id)result {
    NSArray *arr = result[@"articles"];
    if (self.page == 1) {
        [self.dateList removeAllObjects];
    }
    if (arr.count) {
        for (NSDictionary *dic in arr) {
            [self.dateList addObject:[NewsModel mj_objectWithKeyValues:dic]];
        }
    }
}

/**
 获取搜索热词的请求方法
 */
- (void)helperGetHotWordsWithPath:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:@{} outParse:^(id retData, NSError *error) {
        if (!error) {
            callback(retData, nil);
        }
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}


/**
 获取搜索结果文章列表
 */
- (void)helperGetSearchArticleWithPath:(NSString *)path params:(NSDictionary *)parms callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:parms outParse:^(id retData, NSError *error) {
        if (!error) {
            callback(retData, nil);
        }
    } callback:^(id obj, NSError *error) {
        callback(error, nil);
    }];
}

@end
