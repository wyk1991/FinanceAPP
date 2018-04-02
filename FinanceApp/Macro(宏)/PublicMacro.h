//
//  PublicMacro.h
//  SSS_MALL
//
//  Created by 徐洋 on 2017/8/2.
//  Copyright © 2017年 Losdeoro24K. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...) {}
#endif

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define kScreenWidth                    ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight                  ([[UIScreen mainScreen] bounds].size.height)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define kWindow [[UIApplication sharedApplication].delegate window]

#define k_text_font_args(obj) [UIFont systemFontOfSize:obj]

#define k_text_font_args(obj) [UIFont systemFontOfSize:obj]
#define k_textB_font_args(obj) [UIFont boldSystemFontOfSize:obj]


#define kNSUserDefaults [NSUserDefaults standardUserDefaults]

#define kUserInfoHelper (UserInfoModelHelper *) [UserInfoModelHelper shareInstance]

/** iphoneX 适配 */
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define SafeAreaTopHeight (UI_SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaBottomHeihgt (UI_SCREEN_HEIGHT == 812.0 ? 34 : 0)

#define kNavigationHeigh 64
#define kTabBarHeigh 49

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


#define k_user_length_max 11
#define k_user_length_min 11

#define k_pwd_length_max 12
#define k_pwd_length_min 6

#define kPage_Size 20

#define k_leftMargin CalculateWidth(15)

/** 编辑菜单栏 */
#define SPACE CalculateWidth(10)

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

/**
 View圆角和边框
 */
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOs8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)

#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 50 : 20)


#define CalculateWidth(obj) (obj)*kScreenWidth / 375.f
#define CalculateHeight(obj) (obj)*kScreenHeight / 667.f

#define kApplicationDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
//Fixed information
#define kServerPhone @"4008001234"
#define kServerQQ @"4008001234"
#define kServerWechat @"4008001234"
#define kServerE_mail @"4008@shangxiang.com"
#define kServerUrl @"www.baidu.com"


// cell identifier
static NSString *normalPersonCellIden = @"normalPersonCellIden";

//数据验证

#define StrValid(f)(f!=nil &&[f isKindOfClass:[NSString class]]&& ![f isEqualToString:@""])

#define SafeStr(f)(StrValid(f)?f:@"")

#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f)StrValid(f)

#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])

#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)

#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])

#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])

#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])

#define RGBColor(r,g,b) RGBAColor(r,g,b,1.0)
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/** 微信配置账号 */
static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"xxx";



#endif /* PublicMacro_h */
