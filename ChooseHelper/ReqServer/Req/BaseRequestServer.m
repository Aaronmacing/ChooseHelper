#import "BaseRequestServer.h"
#import "NSString+StringUtil.h"
static NSString *TOKEN;
static NSString * const app_key = @"20670E86018AF84D234D7043AE323C25";
static NSString * const app_secret = @"IDkKZdnZFxiH4Kv5MU3tS4PnAs1dN7e9kGG6rDEYgaAQeMD6lfJttJzhzXFUGDwgbuoGqZZ7GBErz";
@implementation BaseRequestServer

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
          andSuccess:(void(^)(Data *returnData))success
          andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
      
        if (![url isEqualToString:URL_USER_LOGIN] && ![url isEqualToString:URL_USER_SIGN_UP]) {
            
             [parameter setObject:TOKEN?TOKEN:@"" forKey:@"token"];
        }
        [parameter setObject:app_key forKey:@"app_key"];
        NSMutableDictionary *temDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
        [temDic setObject:url forKey:@"s"];
        [parameter setObject:[self signStrByDic:temDic] forKey:@"sign"];
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
          andSuccess:(void(^)(Data *returnData))success
          andFailure:(void(^)(NSString *msg))failure{
   
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
        
        if (![url isEqualToString:URL_USER_LOGIN] && ![url isEqualToString:URL_USER_SIGN_UP]) {
            
            [parameter setObject:TOKEN?TOKEN:@"" forKey:@"token"];
        }
        [parameter setObject:app_key forKey:@"app_key"];
        NSMutableDictionary *temDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
        [temDic setObject:url forKey:@"s"];
        [parameter setObject:[self signStrByDic:temDic] forKey:@"sign"];
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
        
        requestUrl = [NSString stringWithFormat:@"%@%@%@",PROTOCOL,SERVER_IP,url];
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
              andSuccess:(void(^)(Data *returnData))success
              andFailure:(void(^)(NSString *msg))failure{
    
    if ([parameter isKindOfClass:[NSMutableDictionary class]]) {
        
        parameter = (NSMutableDictionary *)parameter;
       
        if (![url isEqualToString:URL_USER_LOGIN] && ![url isEqualToString:URL_USER_SIGN_UP]) {
            
            [parameter setObject:TOKEN?TOKEN:@"" forKey:@"token"];
        }
      
        
        [parameter setObject:app_key forKey:@"app_key"];
        NSMutableDictionary *temDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
        [temDic setObject:url forKey:@"s"];
        [parameter setObject:[self signStrByDic:temDic] forKey:@"sign"];
      

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
               andSuccess:(void(^)(Data *returnData))success
               andFailure:(void(^)(NSString *msg))failure{
    if (responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"JSON----------->:\n%@",result);
        RequestResultVO *returnData = [RequestResultVO yy_modelWithJSON:result];
        if (returnData.ret == 200) {
            
            if (returnData.data.err_code == 0) {
             
                success(returnData.data);
                if ([NSString isNotBlankString:returnData.data.token]) {
                    
                    TOKEN = returnData.data.token;
                }
                
            }else{
                
                failure(returnData.data.err_msg);
            }
        }else{
            
            failure(returnData.msg);
            
        }
    }else{
        failure(DEFAULT_ERROR_MSG);
    }
}

- (NSString *)signStrByDic:(NSDictionary *)dict{
    
    //将所有的key放进数组
    NSArray *allKeyArray = [dict allKeys];
    
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id _Nonnull obj2) {
       
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    NSLog(@"afterSortKeyArray:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:[valueArray componentsJoinedByString:@""]];
    [mutableString appendString:app_secret];
    
    NSString *md5Str = [mutableString stringToMD5];
    
    md5Str = md5Str.uppercaseString;
    
    return md5Str;
}

@end
