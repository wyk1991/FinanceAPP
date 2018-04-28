//
//  UserInfoModelHelper.m
//  FinanceApp
//
//  Created by SX on 2018/4/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "UserInfoModelHelper.h"

@implementation UserInfoModelHelper
static UserInfoModelHelper *_instance;
- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super init];
        }
    });
    return _instance;
}

+ (UserInfoModelHelper *)shareInstance {
    return [[self alloc] init];
}

- (void)loginButtonWithUserInfo:(NSDictionary *)userInfo callback:(UICallback)callback {
    [self startPostRequest:userLogin inParam:userInfo outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            callback(retData, error);
        }
    } callback:^(id obj, NSError *error) {
        [LDToast showToastWith:obj[@"status"]];
        callback(error, nil);
    }];
}

- (void)logout:(UICallback)callback {
    [SVProgressHUD showInfoWithStatus:@"正在退出.."];
    [self startPostRequest:userLoginOut inParam:@{} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            callback(retData, error);
        }
    } callback:^(id obj, NSError *error) {
        
    }];
}
@end
