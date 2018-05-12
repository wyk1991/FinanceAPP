//
//  AppDelegate.h
//  FinaceApp
//
//  Created by SX on 2018/3/1.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@class UserInfoModelHelper;
@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 极光注册id */
@property (nonatomic, copy) NSString *registrationID;
/** 当前的网络状况 */
@property (nonatomic, strong) NSString *netState;
/** 个人信息保存方法类 */
@property (nonatomic, assign) UserInfoModelHelper *userHelper;

- (void)monitorNetworking;
@end

