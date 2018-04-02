//
//  BaseViewModel.h
//  FinanceApp
//
//  Created by SX on 2018/3/18.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义标准的C层回调block。这里面的obj会根据不同对象的方法的返回而有差异。
typedef void (^UICallback)(id obj, NSError * error);

//这里定义标准的数据解析block,这个block供M层内部解析用，不对外暴露
typedef void (^DataParse)(id retData, NSError * error);

@interface BaseViewModel : NSObject

- (void)startPostRequest:(NSString*)url  inParam:(id)inParam outParse:(DataParse)outParse  callback:(UICallback)callback;

- (void)startGETRequest:(NSString*)url  inParam:(id)inParam outParse:(DataParse)outParse  callback:(UICallback)callback;

- (void)startPUTRequest:(NSString *)url inParam:(id)inParam outParse:(DataParse)outParse callback:(UICallback)callback;

@end
