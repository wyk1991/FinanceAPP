//
//  AppDelegate.h
//  FinaceApp
//
//  Created by SX on 2018/3/1.
//  Copyright © 2018年 YULING. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 极光注册id */
@property (nonatomic, copy) NSString *registrationID;
@end

