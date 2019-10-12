//
//  AccountDao.h
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "RootDao.h"
#import "Account.h"
NS_ASSUME_NONNULL_BEGIN

@interface AccountDao : RootDao

SingletonH(AccountDao)

- (Account *)queryLoginUser;

- (Account *)queryAccountByAccount:(NSString *)account;

@end

NS_ASSUME_NONNULL_END
