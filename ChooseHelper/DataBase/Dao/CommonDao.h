//
//  CommonDao.h
//  stockHelper
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseDao.h"
#import "AccountDao.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommonDao : BaseDao

- (BOOL)createOrUpgradeTable;

- (void)setDBQueue;

@end

NS_ASSUME_NONNULL_END
