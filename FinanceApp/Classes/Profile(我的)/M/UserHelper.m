//
//  UserHelper.m
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UserHelper.h"
#import "FeedBackListModel.h"

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

- (NSMutableArray *)columnList {
    if (!_columnList) {
        _columnList = @[].mutableCopy;
    }
    return _columnList;
}

- (NSMutableArray *)feedbackList {
    if (!_feedbackList) {
        _feedbackList = @[].mutableCopy;
    }
    return _feedbackList;
}

- (void)helpGetMyColumnData:(NSString *)path withParms:(NSDictionary *)dic callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:dic outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil,error);
    }];
}

- (void)helpPostWithPath:(NSString *)path withInfo:(NSDictionary *)dic callBackBlock:(UICallback)callback
{
    WS(weakSelf);
    [weakSelf startPostRequest:path inParam:dic outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [SVProgressHUD dismiss];
            callback(retData, nil);
        
        } else {
            [LDToast showToastWith:@"提交失败"];
            
        }
    } callback:^(id obj, NSError *error) {
        callback(nil,error);
    }];
}

- (void)helpFeedBackHistoryWithPath:(NSString *)path callBack:(UICallback)callback {
    WS(weakSelf);
    [weakSelf startGETRequest:path inParam:@{@"session_id": @"1"} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            if (self.feedbackList.count) {
                [self.feedbackList removeAllObjects];
            }
            self.feedbackList = [FeedBackListModel mj_objectArrayWithKeyValuesArray:retData[@"feedbacks"]];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        callback(nil,error);
    }];
}

@end
