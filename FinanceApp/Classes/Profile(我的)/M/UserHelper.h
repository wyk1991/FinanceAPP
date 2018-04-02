//
//  UserHelper.h
//  FinanceApp
//
//  Created by SX on 2018/3/28.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@interface UserHelper : BaseViewModel

+ (instancetype)shareHelper;

- (void)helpRegisterUserWithPath:(NSString *)path params:(NSDictionary *)userDic callBack:(UICallback)callback;

- (void)helpGetVerifyCodeNum:(NSString *)path withParams:(NSDictionary *)dic callBack:(UICallback)callback;

- (void)helpLoginWithPath:(NSString *)path params:(NSDictionary *)userInfo callBack:(UICallback)callback;

- (void)heloLoginOutWithPath:(NSString *)path withCallBack:(UICallback)callback;

@end
