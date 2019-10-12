//
//  RootDao.m
//  Travel Plan
//
//  Created by Apple on 2019/7/18.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "RootDao.h"

@implementation RootDao

- (instancetype)init{
    
    if (self = [super init]) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentaryDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentaryDirectory stringByAppendingPathComponent:@"AccountDB.db"];
        NSLog(@"dbPath = %@",dbPath);
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
    }
    return self;
}

- (BOOL)createOrUpdateTable{
    
    __block BOOL isSuccess = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if (![db open]) {
            
            NSLog(@"Open DB Failed");
            return;
        }
        
        NSMutableString *sql = [[NSMutableString alloc] init];
        
        if ([db tableExists:@"Account"]) {
            

        }else{
            
            [sql appendString:@"CREATE TABLE Account (account PRIMARY KEY,password varchar(20),name varchar(20),avatar varchar(20),uuid varchar(20),stockNums varchar(20),stockComps varchar(20));"];
        }

        if (sql.length > 0 && [db executeStatements:sql]) {
            
            NSLog(@"表已创建或升级成功!");
            isSuccess = YES;
        }
        
    }];
    return isSuccess;
}

@end
