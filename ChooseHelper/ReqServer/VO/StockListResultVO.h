//
//  StockListResultVO.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DataList;
@interface StockListResultVO : NSObject

@property (nonatomic, copy) NSString *num;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) NSString *totalCount;

@property (nonatomic, copy) NSString *page;

@end
@interface DataList : NSObject

@property (nonatomic,copy) NSString *preclose;

@property (nonatomic,copy) NSString *prevclose;

@property (nonatomic,copy) NSString *diff;

@property (nonatomic,copy) NSString *lasttrade;

@property (nonatomic,copy) NSString *trade;

@property (nonatomic,copy) NSString *cname;

@property (nonatomic,copy) NSString *chg;

@property (nonatomic,copy) NSString *price;

@property (nonatomic, copy) NSString *settlement;

@property (nonatomic, copy) NSString *engname;

@property (nonatomic, copy) NSString *volume;

@property (nonatomic, copy) NSString *sell;

@property (nonatomic, copy) NSString *high;

@property (nonatomic, copy) NSString *symbol;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *buy;

@property (nonatomic, copy) NSString *low_52week;

@property (nonatomic, copy) NSString *stocks_sum;

@property (nonatomic, copy) NSString *changepercent;

@property (nonatomic, copy) NSString *open;

@property (nonatomic, copy) NSString *low;

@property (nonatomic, copy) NSString *pricechange;

@property (nonatomic, copy) NSString *ticktime;

@property (nonatomic, copy) NSString *high_52week;

@property (nonatomic, copy) NSString *name;


@end


NS_ASSUME_NONNULL_END
