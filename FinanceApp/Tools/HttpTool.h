//
//  HttpTool.h
//  FinanceApp
//
//  Created by SX on 2018/4/23.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//定义标准的C层回调block。这里面的obj会根据不同对象的方法的返回而有差异。
typedef void (^UICallback)(id obj, NSError * error);

//这里定义标准的数据解析block,这个block供M层内部解析用，不对外暴露
typedef void (^DataParse)(id retData, NSError * error);

@interface HttpTool : NSObject

// 带缓存的数据请求
+ (void)getRequestCacheURLStr:(NSString *)url dataField:(NSString *)df inParam:(id)inParam outParse:(DataParse)outParse callback:(UICallback)callback;


+ (void)afnNetworkPostParameter:(NSDictionary *)param toPath:(NSString *)path success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;
+ (void)afnNetworkGetFromPath:(NSString *)path and:(NSDictionary *)param success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail;

+ (void)startUploadImage:(UIImage *)img toPath:(NSString *)path with:(NSDictionary *)params outParse:(DataParse)outParse callback:(UICallback)callback;

#pragma mark ---
#pragma mark ---   计算一共缓存的数据的大小
+ (NSString *)cacheSize;

#pragma mark ---
#pragma mark ---   清空缓存的数据
+ (void)deleateCache;

/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;
@end
