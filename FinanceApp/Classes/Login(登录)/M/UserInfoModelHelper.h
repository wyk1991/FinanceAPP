//
//  UserInfoModelHelper.h
//  FinanceApp
//
//  Created by SX on 2018/4/27.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"
#import "UserInfoModel.h"

@interface UserInfoModelHelper : BaseViewModel
+ (BaseViewModel *)shareInstance;

@property (nonatomic, strong) UserInfoModel *userInfo;

//定义登录方法，注意这个登录方法的实现内部可能会连续做N个网络请求，但是我们要求都在login方法内部处理，而不暴露给C层。
- (void)loginButtonWithUserInfo:(NSDictionary *)userInfo callback:(UICallback)callback;
//定义退出登录方法
- (void)logout:(UICallback)callback;

@end
