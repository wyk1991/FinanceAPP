//
//  HttpTool.m
//  FinanceApp
//
//  Created by SX on 2018/4/23.
//  Copyright © 2018年 wyk. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

static FMDatabase *_db;
+ (void)getRequestCacheURLStr:(NSString *)url dataField:(NSString *)df inParam:(id)inParam outParse:(DataParse)outParse callback:(UICallback)callback
{
//    [self requestWithUrl:url parameters:nil dataField:df isCache:YES imageKey:nil withData:nil callback:callback];
    [[self alloc] requestWithUrl:url parameters:nil dataField:df isCache:YES imageKey:nil withData:nil callback:callback];
}

#pragma mark -- 网络请求统一处理
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
             dataField:(NSString *)dataF
               isCache:(BOOL)isCache
              imageKey:(NSString *)attach
              withData:(NSData *)data
              callback:(UICallback)callback{
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]; // ios9
    NSString * cacheUrl = [self urlDictToStringWithUrlStr:url WithDict:parameters];
    
    NSData * cacheData;
    if (isCache) {
        cacheData = [self cachedDataWithUrl:cacheUrl];
        if(cacheData.length != 0){ // 有缓存的数据
            [self returnDataWithRequestData:cacheData dataField:dataF callback:^(id obj, NSError *error) {
                callback(obj, error);
            }];
        }
    }
    //请求前网络检查
    if(![self requestBeforeCheckNetWork]){
        [LDToast showToastWith:@"当前无网络"];
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/json", @"text/javascript",nil];
    [manager.requestSerializer setTimeoutInterval:10];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask * op;
    op = [manager GET:[NSString stringWithFormat:@"%@%@", Base_URL, url] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dealwithResponseObject:responseObject cacheUrl:url dataField:dataF cacheData:cacheData isCache:YES callback:callback];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callback(error, nil);
    }];
    
}

- (void)dealwithResponseObject:(NSData *)responseData
                      cacheUrl:(NSString *)cacheUrl
                        dataField:(NSString *)dataF
                     cacheData:(NSData *)cacheData
                       isCache:(BOOL)isCache
                      callback:(UICallback)callback{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    NSString * dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    // 清除缓存数据
    dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requstData=[dataString dataUsingEncoding:NSUTF8StringEncoding];
    if (isCache) {/**更新缓存数据*/
        [self saveData:requstData url:cacheUrl];
    }
    if (!isCache || ![cacheData isEqual:requstData]) {
//        [self returnDataWithRequestData:requstData Success:^(NSDictionary *requestDic, NSString *msg) {
//            MCLog(@"网络数据\n\n    %@   \n\n",requestDic);
//            success(requestDic,msg);
//        } failure:^(NSString *errorInfo) {
//            failure(errorInfo);
//        }];
        [self returnDataWithRequestData:requstData dataField:dataF callback:^(id obj, NSError *error) {
            callback(obj, error);
        }];
    }
}

#pragma mark - inner method -----

#pragma mark -- 拼接 post 请求的网址
- (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters{
    if (!parameters) {
        return urlStr;
    }
    NSMutableArray *parts = [NSMutableArray array];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id<NSObject> obj, BOOL *stop) {
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *encodedValue = [obj.description stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject: part];
    }];
    NSString *queryString = [parts componentsJoinedByString: @"&"];
    queryString =  queryString ? [NSString stringWithFormat:@"?%@", queryString] : @"";
    NSString * pathStr =[NSString stringWithFormat:@"%@?%@",urlStr,queryString];
    return pathStr;
}

#pragma mark --根据返回的数据进行统一的格式处理  ----requestData 网络或者是缓存的数据----
- (void)returnDataWithRequestData:(NSData *)requestData dataField:(NSString *)dataField callback:(UICallback)callback{
    id myResult = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    if ([myResult isKindOfClass:[NSDictionary  class]]) {
        NSDictionary *  requestDic = (NSDictionary *)myResult;
        NSInteger status = [requestDic[@"status"] integerValue];
        if (status == 100) {
//            success(requestDic[@"info"],requestDic[@"msg"]);
            callback(requestDic[dataField],nil);
        }else{
            callback(nil,requestDic[@"msg"]);
        }
    }
}

#pragma mark  请求前统一处理：如果是没有网络，则不论是GET请求还是POST请求，均无需继续处理
- (BOOL)requestBeforeCheckNetWork {
    struct sockaddr zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sa_len = sizeof(zeroAddress);
    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}

#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

#pragma mark - ---------- FMDB  method -----------
+ (void)initialize{
    NSString * bundleName =[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    NSString *dbName=[NSString stringWithFormat:@"%@%@",bundleName,@".sqlite"];
    NSString *filename = [cachePath stringByAppendingPathComponent:dbName];
    _db = [FMDatabase databaseWithPath:filename];
    if ([_db open]) {
        BOOL res = [_db tableExists:@"JLData"];
        if (!res) {
            // 4.创表
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS JLData (id integer PRIMARY KEY AUTOINCREMENT, url text NOT NULL, data blob NOT NULL,savetime date);"];
            NSLog(@"\n\n---%@----\n\n",result?@"成功创表":@"创表失败");
        }
    }
    [_db close];
}
#pragma mark --通过请求参数去数据库中加载对应的数据
- (NSData *)cachedDataWithUrl:(NSString *)url{
    NSData * data = [[NSData alloc]init];
    [_db open];
    FMResultSet *resultSet = nil;
    resultSet = [_db executeQuery:@"SELECT * FROM JLData WHERE url = ?", url];
    // 遍历查询结果
    while (resultSet.next) {
        NSDate *  time = [resultSet dateForColumn:@"savetime"];
        NSTimeInterval timeInterval = -[time timeIntervalSinceNow];
        if(timeInterval > cacheTime &&  cacheTime!= 0){
            NSLog(@"\n\n     %@     \n\n",@"缓存的数据过期了");
        }else{
            data = [resultSet objectForColumnName:@"data"];
        }
    }
    [_db close];
    return data;
}

#pragma mark -- 缓存数据到数据库中
- (void)saveData:(NSData *)data url:(NSString *)url{
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"select * from JLData where url = ?",url];
    if([rs next]){
        BOOL res  =[_db executeUpdate: @"update JLData set data =?,savetime =? where url = ?",data,[NSDate date],url];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据更新成功":@"数据更新失败");
    }
    else{
        BOOL res =  [_db executeUpdate:@"INSERT INTO JLData (url,data,savetime) VALUES (?,?,?);",url, data,[NSDate date]];
        NSLog(@"\n\n%@     %@\n\n",url,res?@"数据插入成功":@"数据插入失败");
    }
    [_db close];
}

#pragma mark - 计算一共缓存的数据的大小
+ (NSString *)cacheSize {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *subPaths  = [mgr subpathsAtPath:cachePath];
    double ttotalSize = 0;
    for (NSString  *subpath in subPaths) {
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subpath];
        BOOL dir = NO;
        [mgr fileExistsAtPath:fullPath isDirectory:&dir];
        if (dir == NO) {
            ttotalSize += [[mgr attributesOfItemAtPath:fullPath error:nil][NSFileSize] longLongValue];
        }
    }// M
//    ttotalSize = ttotalSize / 1024;
//    return [NSString stringWithFormat:@"%4.2f %@", ttotalSize, [tokens objectAtIndex:multiplyFactor]];
    return [self transformedValue:[NSString stringWithFormat:@"%f", ttotalSize]];
}

+ (NSString *)transformedValue:(id)value
{
    
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

/**
 *  获取文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

#pragma mark ---   清空缓存的数据
+ (void)deleateCache{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:cachePath error:nil];
}

+ (void)afnNetworkPostParameter:(NSDictionary *)param toPath:(NSString *)path success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/json", @"text/javascript",nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_URL, path];
    
    [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id  _Nonnull formData) {
        // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 这里可以获取到目前的数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        //        if ([responseObject[@"msg"] isEqualToString:@"未登录"]) {
        //            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginOutSuccessNotification object:nil];
        //            [SVProgressHUD showInfoWithStatus:@"请先登录"];
        //            return ;
        //        }
        
        if (responseObject) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //代理实现
        fail(error);
    }];
    
}

+ (void)afnNetworkGetFromPath:(NSString *)path and:(NSDictionary *)param  success:(void(^)(id result))success orFail:(void(^)(NSError *error))fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"text/json", @"text/javascript",nil];
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];//证书的路径
    
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    
    [manager setSecurityPolicy:securityPolicy];
    
    
    [manager GET:path parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    } ];
}

+ (void)startUploadImage:(UIImage *)img toPath:(NSString *)path with:(NSDictionary *)params outParse:(DataParse)outParse callback:(UICallback)callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_URL, path];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.1);
    NSString *imageDataStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //添加参数
    NSMutableDictionary *inParam = params.mutableCopy;
    [inParam setObject:imageDataStr forKey:@"base64data"];
    [inParam setObject:kApplicationDelegate.userHelper.userInfo.token forKey:@"session_id"];
    [inParam setObject:@"jpeg" forKey:@"format"];
    
    [manager POST:urlStr parameters:inParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] integerValue] == 100) {
            outParse(responseObject[@"url"], nil);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(task,error);
    }];
}

@end
