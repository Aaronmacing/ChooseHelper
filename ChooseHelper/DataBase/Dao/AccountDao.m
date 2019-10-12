//
//  AccountDao.m
//  stockHelper
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AccountDao.h"

@implementation AccountDao

SingletonM(AccountDao)

-(Account *)queryLoginUser{
    
    __block NSMutableArray *accountList = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sqlStr = @"SELECT * FROM Account Where TRIM(password) != ''";
        FMResultSet *rs = [db executeQuery:sqlStr];
        while ([rs next]) {
            Account *account = [Account yy_modelWithDictionary:[rs resultDictionary]];
            [accountList addObject:account];
        }
        [rs close];
    }];
    
    if (accountList && accountList.count > 0) {
        
        return accountList[0];
    }
    return nil;
}

- (Account *)queryAccountByAccount:(NSString *)account{
    
    __block NSMutableArray *accountList = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM Account Where account = '%@'",account];
        FMResultSet *rs = [db executeQuery:sqlStr];
        while ([rs next]) {
            Account *account = [Account yy_modelWithDictionary:[rs resultDictionary]];
            [accountList addObject:account];
        }
        [rs close];
    }];
    
    if (accountList && accountList.count > 0) {
        
        return accountList[0];
    }
    return nil;
}

@end
