//
//  StockRequetServer.m
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockRequetServer.h"
//#import "NSDictionary+NilSafe.h"
@implementation StockRequetServer

SingletonM(StockRequetServer)

- (void)getStockListByPage:(NSInteger)page
                        type:(NSInteger)type
                 stockMarket:(StockMarket)stockMarket
                     success:(void (^)(NSArray<StockListResultVO *> * _Nonnull))success
                     failure:(void (^)(NSString * _Nonnull))failure{
    
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{@"page":@(page),@"type":@(type)}];
    
    NSString *url;
    switch (stockMarket) {
        case Shanghai:
            url = URL_STOCK_SH_LIST;
            break;
        case Shenzhen:
            url = URL_STOCK_SZ_LIST;
            break;
        case HongKong:
            url = URL_STOCK_HK_LIST;
            break;
        case USA:
            url = URL_STOCK_USA_LIST;
            break;
    }
    
    
    [self excuteWithUrl:url andParameter:parm andFile:nil andSuccess:^(id returnData) {
        
        StockListResultVO *vo = [StockListResultVO yy_modelWithJSON:returnData];
       
        success(vo.data);
    } andFailure:^(NSString * _Nonnull msg) {
        failure(msg);
    }];
}

- (void)getStockSingleByCode:(NSString *)code type:(NSNumber *)type stockMarket:(StockMarket)stockMarket success:(void (^)(id _Nonnull))success failure:(void (^)(NSString * _Nonnull))failure{
    

    if ([code containsString:@"sz"] || [code containsString:@"sh"]){

        
        code = [code stringByReplacingOccurrencesOfString:@"sz" withString:@""];
        code = [code stringByReplacingOccurrencesOfString:@"sh" withString:@""];
    }

    NSString *codeKey;
    id codeStr;
    NSString *url;
    switch (stockMarket) {
        case Shanghai:
            codeKey = @"gid";
            url = URL_STOCK_SHSS_SINGLE;
            codeStr = [NSString stringWithFormat:@"sh%@",code];
            break;
        case Shenzhen:
            codeKey = @"gid";
            url = URL_STOCK_SHSS_SINGLE;
            codeStr = [NSString stringWithFormat:@"sz%@",code];
            break;
        case HongKong:
            codeKey = @"num";
            url = URL_STOCK_HK_SINGLE;
            codeStr = code;
            break;
        case USA:
            url = URL_STOCK_USA_SINGLE;
            codeKey = @"gid";
            codeStr = code;
            break;
        default:
            break;
    }
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] initWithDictionary:@{codeKey:codeStr}];
    
    if (type) {
    
        [parm removeAllObjects];
        [parm setObject:type forKey:@"type"];
    }
    
    [self excuteWithUrl:url andParameter:parm andFile:nil andSuccess:^(id returnData) {
        
        if (type) {
            
            IndexVO *vo = [IndexVO yy_modelWithJSON:returnData];
            success(vo);
            return;
        }

        if ([returnData isKindOfClass:[NSArray class]]) {
            
            NSDictionary *dic = returnData[0];
          
            StockSingleResultVO *vo = [StockSingleResultVO yy_modelWithJSON:dic];
            success(vo);
        }else{
            
            success([[StockListResultVO alloc] init]);

        }
    } andFailure:^(NSString * _Nonnull msg) {
        failure(msg);
    }];
}


- (void)getNewsByType:(NSString *)type success:(void (^)(NSArray * newsList))success failure:(void (^)(NSString *msg))failure{
    
    NSMutableDictionary *parm = [NSMutableDictionary new];
    [parm setObject:type forKey:@"type"];
    
    [self excuteNewsWithUrl:URL_STOCK_NEWS_SINGLE andParameter:parm andSuccess:^(id returnData) {
        StockNewsModel * mod = [StockNewsModel yy_modelWithJSON:returnData];
        success(mod.data);

    } andFailure:^(NSString *msg) {
        failure(msg);

    }];
    
}


@end
