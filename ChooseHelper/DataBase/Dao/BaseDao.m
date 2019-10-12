//
//  BaseDao.m
//  iOSBaseFramework
//
//  Created by WeiLin on 16/6/23.
//  Copyright © 2016年 LIN. All rights reserved.
//

#import "BaseDao.h"
#import <objc/runtime.h>
#import "AppMacro.h"


@implementation BaseDao


-(BOOL)insertData:(id)object{
    
    NSLog(@"insertData start");
    
    __block BOOL isRollBack = NO;
    
    if (!object) {
        
        NSLog(@"插入空数据，直接返回");
        return NO;
    }
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        NSLog(@"insertData inDatabase");

        [db beginTransaction];
        
        @try {
            NSMutableArray *array = [NSMutableArray array];
            if ([object isKindOfClass:[NSArray class]]) {
                array = object;
            }else{
                [array addObject:object];
            }
            
            if (array.count == 0) {
                
                NSLog(@"插入空数据，直接返回");
                return;
            }
            
            id tempObj = array[0];
            NSString *tableName = [NSString stringWithUTF8String:object_getClassName(tempObj)];
            
            for (NSObject *obj in array) {
               
                [self getObjectPropertyAndValue:^(NSMutableArray *propertyArray, NSMutableArray *valueArray) {
                    NSMutableString *sql = [[NSMutableString alloc] initWithString:@"INSERT INTO "];
                    [sql appendFormat:@"%@ (",tableName];
                    
                    NSInteger pCount = propertyArray.count;
                    for (int i = 0; i < pCount; i++) {
                        if (i == (pCount-1)) {
                            [sql appendFormat:@"%@) VALUES (",propertyArray[i]];
                        }else{
                            [sql appendFormat:@"%@, ",propertyArray[i]];
                        }
                        
                    }
                    
                    NSInteger vCount = valueArray.count;
                    for (int i = 0; i < vCount; i++) {
                        
                        if (i == (vCount-1)) {
                            [sql appendFormat:@"?)"];
                        }else{
                            [sql appendFormat:@"?,"];
                        }
                        
                    }
#if 1
                    NSLog(@"插入或更新数据SQL = %@",sql);
#endif
                    if(![db executeUpdate:sql withArgumentsInArray:valueArray]){
                        NSLog(@"插入或更新数据失败！SQL = %@",sql);
                        isRollBack = YES;
                    }
                } andObj:obj];
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"使用事务批量插入数据失败！");
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
    }];
    NSLog(@"insertData end");
    return !isRollBack;
}

//插入或更新
- (BOOL)insertOrUpdateData:(id)object{
    
    NSLog(@"insert Or ReplaceData start");
    
    __block BOOL isRollBack = NO;
    
    if (!object) {
        
        NSLog(@"插入空数据，直接返回");
        return NO;
    }
 
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        NSLog(@"insertData inDatabase");
        
        [db beginTransaction];
        
        @try {
            NSMutableArray *array = [NSMutableArray array];
            if ([object isKindOfClass:[NSArray class]]) {
                array = object;
            }else{
                [array addObject:object];
            }
            
            if (array.count == 0) {
                
                NSLog(@"插入空数据，直接返回");
                return;
            }
            
            id tempObj = array[0];
            NSString *tableName = [NSString stringWithUTF8String:object_getClassName(tempObj)];
            
            for (NSObject *obj in array) {
                
               
                [self getObjectPropertyAndValue:^(NSMutableArray *propertyArray, NSMutableArray *valueArray) {
                    
                    NSMutableString *sql = [[NSMutableString alloc] initWithString:@"INSERT OR REPLACE INTO "];
                    [sql appendFormat:@"%@ (",tableName];
                    
                    NSInteger pCount = propertyArray.count;
                    for (int i = 0; i < pCount; i++) {
                        if (i == (pCount-1)) {
                            [sql appendFormat:@"%@) VALUES (",propertyArray[i]];
                        }else{
                            [sql appendFormat:@"%@, ",propertyArray[i]];
                        }
                        
                    }
                    
                    NSInteger vCount = valueArray.count;
                    for (int i = 0; i < vCount; i++) {
                        
                        if (i == (vCount-1)) {
                            [sql appendFormat:@"?)"];
                        }else{
                            [sql appendFormat:@"?,"];
                        }
                        
                    }
                    
#if 1
                    NSLog(@"插入或更新数据SQL = %@",sql);
#endif
                    if(![db executeUpdate:sql withArgumentsInArray:valueArray]){
                        NSLog(@"插入或更新数据失败！SQL = %@",sql);
                        isRollBack = YES;
                    }
                } andObj:obj];
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"使用事务批量插入或更新数据失败！");
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
    }];
    NSLog(@"insert Or ReplaceData end");
    return !isRollBack;
}


-(BOOL)updateData:(id)object{
    
    __block BOOL isRollBack = NO;
    
    if (!object) {
        
        NSLog(@"更新空数据，直接返回");
        return NO;
    }
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        @try {
            NSMutableArray *array = [NSMutableArray array];
            if ([object isKindOfClass:[NSArray class]]) {
                array = object;
            }else{
                [array addObject:object];
            }
            
            if (array.count == 0) {
                
                return;
            }
            
            id tempObj = array[0];
            NSString *tableName = [NSString stringWithUTF8String:object_getClassName(tempObj)];
            
            for (NSObject *obj in array) {
                
                [self getObjectPropertyAndValue:^(NSMutableArray *propertyArray, NSMutableArray *valueArray) {
                    
                    NSMutableString *sql = [[NSMutableString alloc] initWithString:@"UPDATE "];
                    [sql appendFormat:@"%@ SET ",tableName];
                    
                    NSInteger pCount = propertyArray.count;
                    NSString *idPVStr;
                    for (int i = 0; i < pCount; i++) {
                        
                        id value = valueArray[i];
                        if ([value isKindOfClass:[NSString class]]) {
                            value = [NSString stringWithFormat:@"'%@'",value];
                        }
                        
                        if ([@"id" isEqualToString:propertyArray[i]]) {
                            idPVStr = [NSString stringWithFormat:@"%@ = %@", propertyArray[i], value];
                        }else{
                            if (i == (pCount - 1)) {
                                [sql appendFormat:@"%@ = %@ WHERE %@", propertyArray[i], value, idPVStr];
                            }else{
                                [sql appendFormat:@"%@ = %@ , ",propertyArray[i],value];
                            }
                        }
                        
                    }
                    
                    NSLog(@"UPDATE SQL = %@", sql);
                    
                    if(![db executeUpdate:sql]){
                        NSLog(@"修改数据失败！SQL = %@",sql);
                    }
                    
                } andObj:obj];
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"使用事务批量修改数据失败！");
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
       
    }];
    return !isRollBack;
}

-(NSMutableArray *)queryData:(id)object{
    
    
   return [self queryData:object andOrderNames:nil andIsASC:0];
    
}


-(NSMutableArray *)queryData:(id)object andOrderNames:(NSArray *)orderNamesArray andIsASC:(BOOL)asc{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *sordType;
    if (asc) {
        
        sordType = @"ASC";
    }else{
        
        sordType = @"DESC";
    }
    
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
       
        [self getObjectPropertyAndValue:^(NSMutableArray *propertyArray, NSMutableArray *valueArray) {
            
            NSMutableArray *allPropertyArray = [self getObjectProperty:object];
            
            NSMutableString *sql = [[NSMutableString alloc] initWithString:@"SELECT * FROM "];
            [sql appendString:[NSString stringWithUTF8String:object_getClassName(object)]];
            
            NSInteger pCount = propertyArray.count;
            if (pCount > 0) {
                [sql appendString:@" WHERE "];
                for (int i = 0; i < pCount; i++) {
                    
                    id value = valueArray[i];
                    if ([value isKindOfClass:[NSString class]]) {
                        value = [NSString stringWithFormat:@"'%@'",value];
                    }
                    if (i == (pCount - 1)) {
                        [sql appendFormat:@"%@ = %@", propertyArray[i], value];
                    }else{
                        [sql appendFormat:@"%@ = %@ AND ", propertyArray[i],value];
                    }
                    
                }
            }
            
            NSLog(@"SELECT SQL = %@", sql);
            
            if (orderNamesArray && orderNamesArray.count > 0) {
                
                for (NSUInteger i = 0; i < orderNamesArray.count; i++) {
                    
                    if ([orderNamesArray[i] isKindOfClass:[NSString class]]) {
                        
                        if (i == 0 ) {
                            if (orderNamesArray.count > 1) {
                                
                                 [sql appendString:[NSString stringWithFormat:@" ORDER BY %@ %@,",orderNamesArray[i],sordType]];
                            }else{
                                
                                 [sql appendString:[NSString stringWithFormat:@" ORDER BY %@ %@",orderNamesArray[i],sordType]];
                            }

                        }else if (i == orderNamesArray.count - 1){
                            
                            [sql appendString:[NSString stringWithFormat:@"%@ %@",orderNamesArray,sordType]];
                            
                        }else{
                            
                            [sql appendString:[NSString stringWithFormat:@"%@ %@,",orderNamesArray,sordType]];
                        }
                        
                    }
                }
            }
            
            FMResultSet *rs = [db executeQuery:sql];
            
            while ([rs next]) {
                
                id instanceOfNewClass = [[[object class] alloc]init];
                
                for (NSString *propertyName in allPropertyArray) {
                    [instanceOfNewClass setValue:[rs objectForColumnName:propertyName] forKey:propertyName];
                }
                [array addObject:instanceOfNewClass];
                
            }
            
        } andObj:object];

    }];
    return array;
}

-(BOOL)deleteData:(id)object{
    
    __block BOOL isRollBack = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db beginTransaction];
        
        @try {
            NSMutableArray *array = [NSMutableArray array];
            if ([object isKindOfClass:[NSArray class]]) {
                array = object;
            }else{
                [array addObject:object];
            }
            
            id tempObj = array[0];
            NSString *tableName = [NSString stringWithUTF8String:object_getClassName(tempObj)];
            
            for (NSObject *obj in array) {
                
                [self getObjectPropertyAndValue:^(NSMutableArray *propertyArray, NSMutableArray *valueArray) {
                    
                    NSMutableString *sql = [[NSMutableString alloc] initWithString:@"DELETE FROM "];
                    [sql appendString:tableName];
                    
                    NSInteger pCount = propertyArray.count;
                    if (pCount > 0) {
                        [sql appendString:@" WHERE "];
                        for (int i = 0; i < pCount; i++) {
                            
                            id value = valueArray[i];
                            if ([value isKindOfClass:[NSString class]]) {
                                value = [NSString stringWithFormat:@"'%@'",value];
                            }
                            if (i == (pCount - 1)) {
                                [sql appendFormat:@"%@ = %@", propertyArray[i], value];
                            }else{
                                [sql appendFormat:@"%@ = %@ AND ", propertyArray[i],value];
                            }
                            
                        }
                    }
                    
                    NSLog(@"DELETE SQL = %@", sql);
                    
                    if(![db executeUpdate:sql]){
                        NSLog(@"删除数据失败！SQL = %@",sql);
                    }
                    
                } andObj:obj];
                
            }
            
        } @catch (NSException *exception) {
            NSLog(@"使用事务批量删除数据失败！");
            isRollBack = YES;
            [db rollback];
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
       
    }];
    return !isRollBack;
}

/**
 *  获取对象属性名称和值
 *
 *  @param block 属性名称和值
 *  @param obj   对象
 */
-(void)getObjectPropertyAndValue:(void (^)(NSMutableArray *propertyArray,NSMutableArray *valueArray))block andObj:(NSObject *)obj{
    
    NSMutableArray *propertyArray = [NSMutableArray array];
    NSMutableArray *valueArray = [NSMutableArray array];
    
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propertyName];
        
        if (value != nil && value != NULL && ![value isKindOfClass:[NSNull class]]) {
            [propertyArray addObject:propertyName];
            [valueArray addObject:value];
        }
    }
    block(propertyArray,valueArray);
}

/**
 *  获取对象属性名称
 *
 *  @param obj   对象
 */
-(NSMutableArray *)getObjectProperty:(NSObject *)obj{
    
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        
        [propertyArray addObject:[NSString stringWithUTF8String:property_getName(prop)]];
    }
    return propertyArray;
}

@end
