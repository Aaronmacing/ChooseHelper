//
//  RootDao.h
//  Travel Plan
//
//  Created by Apple on 2019/7/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseDao.h"

NS_ASSUME_NONNULL_BEGIN

@interface RootDao : BaseDao

- (BOOL)createOrUpdateTable;

@end

NS_ASSUME_NONNULL_END
