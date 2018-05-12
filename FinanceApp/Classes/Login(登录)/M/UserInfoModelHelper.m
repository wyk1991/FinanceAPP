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
    WS(weakSelf);
    [weakSelf startPostRequest:userLogin inParam:userInfo outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [weakSelf dealDataWith:retData];
        }
        callback(retData, nil);
    } callback:^(id obj, NSError *error) {
        [LDToast showToastWith:obj[@"status"]];
        callback(error, nil);
    }];
}

- (void)dealDataWith:(id)result {
    self.userInfo = [UserInfoModel mj_objectWithKeyValues:result];
    kApplicationDelegate.userHelper = self;
    // 保存个人偏好设置信息
    [kNSUserDefaults setValue:self.userInfo.token forKey:kAppHasCompletedLoginToken];
    UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:result];
    // 归档数据将数据装换为data格式
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
    [kNSUserDefaults setObject:modelData forKey:kAppHasCompletedLoginUserInfo];
    [kNSUserDefaults synchronize];
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
