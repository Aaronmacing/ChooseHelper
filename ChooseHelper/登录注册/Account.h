//
//  Account.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property (nonatomic,copy) NSString *account;

@property (nonatomic,copy) NSString *password;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *avatar;

@property (nonatomic,copy) NSString *uuid;

@property (nonatomic,strong) NSNumber *isReadMsg;

@end

NS_ASSUME_NONNULL_END
