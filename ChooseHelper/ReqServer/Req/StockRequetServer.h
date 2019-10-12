//
//  StockRequetServer.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockBaseRequestServer.h"
#import "StockListResultVO.h"
#import "StockSingleResultVO.h"
#import "IndexVO.h"
#import "StockNewsModel.h"


typedef NS_ENUM(NSUInteger, StockMarket) {
    Shenzhen = 0,
    USA,
    HongKong,
    Shanghai,
   
};
@interface StockRequetServer : StockBaseRequestServer

SingletonH(StockRequetServer)

- (void)getStockListByPage:(NSInteger)page
                           type:(NSInteger)type
                    stockMarket:(StockMarket)stockMarket
                     success:(void (^)(NSArray <DataList *>*stockList))success
                     failure:(void (^)(NSString *msg))failure;
//type    0代表上证指数，1代表深证指数
- (void)getStockSingleByCode:(NSString *)code
                        type:(NSNumber *)type
                 stockMarket:(StockMarket)stockMarket
                     success:(void (^)(id stockSingle))success
                     failure:(void (^)(NSString *msg))failure;

- (void)getNewsByType:(NSString *)type success:(void (^)(NSArray * newsList))success failure:(void (^)(NSString *msg))failure;


@end


