//
//  SingletonModel.h
//  smallTa
//
//  Created by Apple on 2019/9/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingletonModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger size;
+ (instancetype)sharedLoadData;
@end

NS_ASSUME_NONNULL_END
