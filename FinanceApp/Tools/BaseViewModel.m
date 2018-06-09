//
//  BaseViewModel.m
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel


- (void)startGETRequest:(NSString *)url inParam:(id)inParam outParse:(DataParse)outParse callback:(UICallback)callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/json", @"text/javascript",nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_URL, url];
    
    [manager GET:urlStr parameters:inParam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
            outParse(responseObject,nil);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //代理实现
        callback(task,error);
    }];
}

- (void)startPostRequest:(NSString *)url inParam:(id)inParam outParse:(DataParse)outParse callback:(UICallback)callback {
    [kApplicationDelegate monitorNetworking];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_URL, url];
    
    [manager POST:urlStr parameters:inParam progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            
            outParse(responseObject,nil);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(task,error);
        
    }];
}


@end
