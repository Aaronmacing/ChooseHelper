//
//  StockBaseRequestServer.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AFHTTPSessionManager.h"
#import <YYModel.h>
#import "UrlConst.h"
#import "AppMacro.h"
#import "NSString+StringUtil.h"
#import "StockRequestResultVO.h"
#define DEFAULT_ERROR_MSG @"操作失败，请检查网络后重试！"


@interface StockBaseRequestServer : NSObject

@property (nonatomic,strong) AFHTTPSessionManager * requestManager;


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
          andFailure:(void(^)(NSString *msg))failure;

//新闻
-(void)excuteNewsWithUrl:(NSString *)url andParameter:(id)parameter
              andSuccess:(void(^)(id returnData))success
              andFailure:(void(^)(NSString *msg))failure;


/**
 *  生成请求的URL
 *
 *  @param url 请求的URL方法
 *
 *  @return 完整的URL
 */
-(NSString *)requestURL:(NSString *) url;


/**
 执行网络请求
 
 @param url 请求地址
 @param parameter 参数
 @param fileArray 待上传的图片文件
 @param success 成功返回
 @param failure 失败返回
 */
-(void)excuteWithUrl:(NSString *)url
        andParameter:(id)parameter
             andFile:(NSArray *)fileArray
          andSuccess:(void(^)(id returnData))success
          andFailure:(void(^)(NSString *msg))failure;

/**
 执行GET网络请求
 
 @param url 请求地址
 @param parameter 参数
 @param success 成功返回
 @param failure 失败返回
 */
- (void)excuteWithGetUrl:(NSString *)url andParameter:(id)parameter
              andSuccess:(void(^)(id returnData))success
              andFailure:(void(^)(NSString *msg))failure;


@end

