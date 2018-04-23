//
//  AppDelegate.m
//  FinaceApp
//
//  Created by SX on 2018/3/1.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "WXApi.h"
#import <UMSocialCore/UMSocialCore.h>
#import "JPUSHService.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 注册wechat author登录授权
    [self wechatAuthor];
    // 注册友盟分享
    [self configUSharePlatforms];
    // 注册极光
    [self registerJPushWithOption:launchOptions];
    
    [self initMain];
    
    [self initUserSettingConfig];
    return YES;
}

- (void)initUserSettingConfig {
    if (![kNSUserDefaults valueForKey:user_currency]) {
        [kNSUserDefaults setValue:@"cny" forKey:user_currency];
    }
    if (![kNSUserDefaults valueForKey:user_greenRed]) {
        [kNSUserDefaults setValue:@"redRise" forKey:user_greenRed];
    }
    if (![kNSUserDefaults valueForKey:user_pushSwitch]) {
        [kNSUserDefaults setValue:@"0" forKey:user_pushSwitch];
    }
    if (![kNSUserDefaults valueForKey:user_noticeShackType]) {
        [kNSUserDefaults setValue:@"1" forKey:user_noticeShackType];
    }
    if (![kNSUserDefaults valueForKey:user_noticeVoiceType]) {
        [kNSUserDefaults setValue:@"1" forKey:user_noticeVoiceType];
    }
    if (![kNSUserDefaults valueForKey:user_earlyWaring]) {
        [kNSUserDefaults setValue:@"1" forKey:user_earlyWaring];
    }
}

- (void)initMain {
    // 判断用户是否登录
//    BOOL isLogin = [kNSUserDefaults stringForKey:kUseisLoginWithToke] ? YES : NO;
//    if (isLogin) {
        // 初始化主界面
        
        [self initTabBar];
//    } else {
//        // 跳转登录界面
//
//    }
}

- (void)initTabBar {
    MainTabBarController *main = [[MainTabBarController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = main;
}


- (void)wechatAuthor {
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"wechat-- log :%@", log);
    }];
    
    // 向微信注册
    [WXApi registerApp:@"" enableMTA:YES];
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
    
    // 设置分享回调 所有系统使用
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [WXApi handleOpenURL:url delegate:self];
    
    // 设置分享回调 ios9 以上系统使用
     BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        
    }
    return YES;
}


#pragma mark ------------- UShare -------------
- (void)configUSharePlatforms {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wechatAppkey appSecret:wechatSecret redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:qqAppKey/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //** 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:wechatAppkey appSecret:wechatSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

#pragma mark - --------  JPush  ----------
- (void)registerJPushWithOption:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:jPushKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (resCode == 0) {
            UMSocialPlatformType_QQ
            NSLog(@"registrationID获取成功：%@",registrationID);
            self.registrationID = registrationID;
        } else {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 设置未读消息bage
    
    
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
    // 禁止本地的通知
    [application cancelAllLocalNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
