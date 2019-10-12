//
//  CommonDao.m
//  stockHelper
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "CommonDao.h"

@implementation CommonDao

-(id)init{
    
    self = [super init];
    if (self) {
        
        [self setDBQueue];
    }
    return self;
}
/**
 设置DBQueue
 */
- (void)setDBQueue{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    Account *account = [[AccountDao sharedAccountDao] queryLoginUser];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Stock_%@DB.db",account.account]];
    NSLog(@"dbPath = %@",dbPath);
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
}

-(BOOL)createOrUpgradeTable{
    
    __block BOOL isSuccess = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            NSLog(@"open db failed");
            return ;
        };
        NSMutableString *sql = [[NSMutableString alloc]init];
        
        if ([db tableExists:@"StockNote"]) {
            

        }else{
            
            [sql appendString:@"CREATE TABLE StockNote (id integer PRIMARY KEY,path varchar(20),notes varchar(20),seconds integer);"];
        }
        if(sql.length > 0 && [db executeStatements:sql]){
            NSLog(@"表已创建或升级成功!");
            isSuccess = YES;
        }
    }];
    return isSuccess;
}

@end
