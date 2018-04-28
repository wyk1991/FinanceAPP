//
//  VaildationCodeHelper.m
//  FinanceApp
//
//  Created by SX on 2018/4/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "VaildationCodeHelper.h"

@implementation VaildationCodeHelper

- (void)helperGetValidationCodeCallback:(UICallback)callBack telStr:(NSString *)str {
    [self startGETRequest:verifyTelCode inParam:@{@"phone": str} outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            [LDToast showToastWith:@"success"];
            callBack(retData, error);
        }
        
    } callback:^(id obj, NSError *error) {
        
    }];
}

- (void)helperPostInfo:(NSDictionary *)inParam callback:(UICallback)callBack {
    [self startPostRequest:userRegister inParam:inParam outParse:^(id retData, NSError *error) {
        if ([retData[@"status"] integerValue] == 100) {
            callBack(retData, error);
        }
        [LDToast showToastWith:@"注册成功"];
    } callback:^(id obj, NSError *error) {
        
    }];
}

@end
