//
//  StockListResultVO.m
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "StockListResultVO.h"

@implementation StockListResultVO

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [DataList class]};
}


@end

@implementation DataList

+ (nullable NSDictionary *)modelCustomPropertyMapper{
    
    return @{@"trade":@[@"trade",@"price",@"lasttrade"],@"changepercent":@[@"changepercent",@"chg"],@"name":@[@"name",@"cname"]};
    
}

@end
