//
//  WYCustomSharePlatform.m
//  FinanceApp
//
//  Created by SX on 2018/5/30.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "WYCustomSharePlatform.h"

@implementation WYCustomSharePlatform
+ (void)load {
    [super load];
}

+ (NSArray *) socialPlatformTypes {
    return @[@(UMSocialPlatformType_Link)];
}

+ (instancetype)defaultManager {
    static WYCustomSharePlatform *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

+ (NSString *)platformNameWithPlatformType:(UMSocialPlatformType)platformType {
    return @"复制链接";
}

-(void)umSocial_ShareWithObject:(UMSocialMessageObject *)object
          withCompletionHandler:(UMSocialRequestCompletionHandler)completionHandler {
    UMShareWebpageObject *webObjc = object.shareObject;
    UIPasteboard *pastboad = [UIPasteboard generalPasteboard];
    pastboad.string = webObjc.webpageUrl;
    [LDToast showToastWith:@"链接复制成功"];
}

// 因为我分享的是网页类型，所以 object.shareObject 的类型是 UMShareWebpageObject
-(BOOL)umSocial_handleOpenURL:(NSURL *)url {
    return YES;
}

-(UMSocialPlatformFeature)umSocial_SupportedFeatures {
    return UMSocialPlatformFeature_None;
}

-(NSString *)umSocial_PlatformSDKVersion {
    return [UMSocialGlobal umSocialSDKVersion];
}

-(BOOL)checkUrlSchema {
    return YES;
}

-(BOOL)umSocial_isInstall {
    return YES;
}

-(BOOL)umSocial_isSupport {
    return YES;
}

@end
