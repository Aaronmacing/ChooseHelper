


#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AFHTTPSessionManager.h"
#import <YYModel.h>
#import "UrlConst.h"
//#import "AppMacro.h"
#import "NSString+StringUtil.h"
#import "RequestResultVO.h"
#define DEFAULT_ERROR_MSG @"Please Check Network"

@interface BaseRequestServer : NSObject

@property (nonatomic,strong) AFHTTPSessionManager * requestManager;

///**
// 返回JessionID
// */
//+ (NSString *)getJessionID;
//
//- (void)setJessionID:(NSString *)jessionId;


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
          andSuccess:(void(^)(Data *returnData))success
          andFailure:(void(^)(NSString *msg))failure;

@end
