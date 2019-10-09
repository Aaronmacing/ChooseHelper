//
//  SingletonModel.m
//  smallTa
//
//  Created by Apple on 2019/9/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SingletonModel.h"

@implementation SingletonModel

+ (instancetype)sharedLoadData {
    static SingletonModel *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[SingletonModel alloc] init];
        singleton.name = [[NSString alloc]init];
        singleton.size = 0;
        
    });
return singleton;
}
@end
