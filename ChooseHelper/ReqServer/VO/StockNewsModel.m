//
//  StockNewsModel.m
//  MyStock
//
//  Created by apple on 2019/10/10.
//  Copyright © 2019 CoooooY. All rights reserved.
//

#import "StockNewsModel.h"

@implementation StockNewsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [NewsInfoModel class]};
}

@end

@implementation NewsInfoModel

@end

