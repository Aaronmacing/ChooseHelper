//
//  StockBaseRequestServer.m
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockBaseRequestServer.h"
#import "NSString+StringUtil.h"
//static NSString * const app_key = @"e8adfff2a29a969487712f63c63d1d46";
//static NSString * const app_news_key = @"245dfc05504debd38afed834d735b57d";
//static NSString * const app_exchange_key = @"9095c859aaa51743c12161ec9bf0ad66";

static NSString * const app_key = @"6699cad40f8dbf030b9af626695b8271";
static NSString * const app_news_key = @"b940337cd9d3c6d0db68300f7907da75";
static NSString * const app_exchange_key = @"e157232e0b433175a01806b7e3e7a4c5";


@implementation StockBaseRequestServer

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _requestManager = [AFHTTPSessionManager manager];
        
        //申明请求的数据是json类型
        _requestManager.requestSerializer=[AFJSONRequestSerializer serializer];
        //添加请求的header
        [_requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_requestManager.requestSerializer setValue:[NSString stringWithFormat:@"%0.2f",IOS_VERSION] forHTTPHeaderField:@"device-os-version"];
        // 设置超时时间
        _requestManager.requestSerializer.timeoutInterval = 20.0f;
        
        // AFN不会解析,数据是data，需要自己解析
        _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 申明返回的结果是json类型，AFN会使用JSON解析返回的数据
        //_requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        //接收的类型
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}

/**
 *  执行网络请求方法
 *
 *  @param url       请求地址
 *  @param parameter 参数
 *  @param success   成功返回数据
 *  @param failure   失败返回错误信息
 */
-(void)excuteWithUrl:(NSString *)url andParameter:(id)parameter
          andSuccess:(void(^)(id returnData))success
          andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
        
        [parameter setObject:app_key forKey:@"key"];
    }
    [_requestManager POST:[self requestURL:url] parameters:parameter
                 progress:^(NSProgress * _Nonnull uploadProgress) {
                     
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [self parserResponseData:responseObject andUrl:(NSString *)url andSuccess:success andFailure:failure];
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     failure(DEFAULT_ERROR_MSG);
                     NSLog(@"\n%@:----------->\nError----------->:\n%@", url, error);
                 }];
}


-(void)excuteNewsWithUrl:(NSString *)url andParameter:(id)parameter
          andSuccess:(void(^)(id returnData))success
          andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
        
        [parameter setObject:app_news_key forKey:@"key"];
    }

    [_requestManager GET:[NSString stringWithFormat:@"%@%@%@",PROTOCOL,STOCK_SERVER_IP2,url] parameters:parameter
                 progress:^(NSProgress * _Nonnull uploadProgress) {
                     
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [self parserResponseData:responseObject andUrl:(NSString *)url andSuccess:success andFailure:failure];
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     failure(DEFAULT_ERROR_MSG);
                     NSLog(@"\n%@:----------->\nError----------->:\n%@", url, error);
                 }];
}

/**
 执行网络请求
 
 @param url 请求地址
 @param parameter 参数
 @param fileArray 待上传的图片文件数据
 @param success 成功返回
 @param failure 失败返回
 */
-(void)excuteWithUrl:(NSString *)url
        andParameter:(id)parameter
             andFile:(NSArray *)fileArray
          andSuccess:(void(^)(id returnData))success
          andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
        [parameter setObject:app_key forKey:@"key"];
    }
    
    [_requestManager POST:[self requestURL:url] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileArray && fileArray.count > 0) {
            for (int i=0; i<fileArray.count; i++) {
                id file = fileArray[i];
                NSData *imageData;
                if (![file isKindOfClass:[NSData class]]) {
                    imageData = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:file], 1.0);
                }else{
                    imageData = file;
                }
                [formData appendPartWithFileData:imageData name:@"iconfile" fileName:[NSString stringWithFormat:@"file%i.jpeg",i] mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parserResponseData:responseObject andUrl:url andSuccess:success andFailure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(DEFAULT_ERROR_MSG);
        NSLog(@"\n%@:----------->\nError----------->:\n%@", url, error);
        
    }];
}


- (NSString *)requestURL:(NSString *)url{
    
    NSString *requestUrl;
    if (!requestUrl) {
        
        requestUrl = [NSString stringWithFormat:@"%@%@%@",PROTOCOL,STOCK_SERVER_IP,url];
    }
    NSLog(@"requestUrl=%@",requestUrl);
    return requestUrl;
}

/**
 执行GET网络请求
 
 @param url 请求地址
 @param parameter 参数
 @param success 成功返回
 @param failure 失败返回
 */
- (void)excuteWithGetUrl:(NSString *)url andParameter:(id)parameter
              andSuccess:(void(^)(id returnData))success
              andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
        
        if ([url containsString:URL_EXCHANGE_CURRENCY] || [url containsString:URL_EXCHANGE_COMMON_LIST] || [url containsString:URL_EXCHANGE_CURRENCY_LIST]) {
            
            [parameter setObject:app_exchange_key forKey:@"key"];
        }else{
            
            [parameter setObject:app_key forKey:@"key"];
        }
    }
    [_requestManager GET:[self requestURL:url] parameters:parameter
                progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [self parserResponseData:responseObject andUrl:url andSuccess:success andFailure:failure];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(DEFAULT_ERROR_MSG);
                    NSLog(@"\n%@:----------->\nError----------->:\n%@", url, error);
                }];
}


/**
 解析返回的数据
 
 @param responseObject 返回的结果
 @param success 成功block
 @param failure 失败block
 */
-(void)parserResponseData:(id)responseObject
                   andUrl:(NSString *)url
               andSuccess:(void(^)(id))success
               andFailure:(void(^)(NSString *msg))failure{
    if (responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON----------->:\n%@",result);
        StockRequestResultVO *returnData = [StockRequestResultVO yy_modelWithJSON:result];
        if (returnData.error_code == 0) {
            
                
            success(returnData.result);
        
        }else{
            
            failure(returnData.reason);
        }
    }else{
        failure(DEFAULT_ERROR_MSG);
    }
}

@end
