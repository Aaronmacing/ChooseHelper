//
//  StockRequestResultVO.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockRequestResultVO : NSObject

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, strong) id result;

@property (nonatomic, copy) NSString *reason;

@end

NS_ASSUME_NONNULL_END
