//
//  BaseDao.h
//  iOSBaseFramework
//
//  Created by WeiLin on 16/6/23.
//  Copyright © 2016年 LIN. All rights reserved.
//

/**
 测试手机iPhone6
 1、
 不使用事务插入50000条数据用时72.231秒
 使用事务插入50000条数据用时0.298秒
 2、
 不使用反射插入50000条数据用时0.179秒
 使用反射插入50000条数据用时0.319秒
 3、
 不使用反射插入500000条数据用时15.434秒
 使用反射插入500000条数据用时26.158秒
*/

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"
#import "Singleton.h"
#import <YYModel.h>
@interface BaseDao : NSObject

@property (atomic,strong) FMDatabaseQueue *dbQueue;



/**
 *  插入数据（批量插入大量数据>10000条慎重使用）
 *
 *  @param object 数据array或一个对象
 */
-(BOOL)insertData:(id)object;


/**
 *  插入或更新数据（批量插入大量数据>10000条慎重使用）
 *
 *  @param object 数据array或一个对象
 */
- (BOOL)insertOrUpdateData:(id)object;

/**
 *  根据id更新数据（批量更新大量数据>10000条慎重使用）
 *
 *  @param object 数据array或一个对象
 */
-(BOOL)updateData:(id)object;

/**
 *  删除数据，实体对象属性有值就是条件删除，没有值就是删除此对象所对应表的所有数据（必须传入实体对象）
 *
 *  @param object 数据array或一个对象（不能为空）
 */
-(BOOL)deleteData:(id)object;

/**
 *  查询数据，实体对象属性有值就是条件查询，没有值就是查询所有（必须传入实体对象）
 *
 *  @param object 对象属性条件WHERE或者对象实体（不能为空）
 *
 *  @return 查询的内容
 */
-(NSMutableArray *)queryData:(id)object;


/**
 带排序查询数据,实体对象属性有值就是条件查询，没有值就是查询所有（必须传入实体对象）

 @param object 对象属性条件WHERE或者对象实体（不能为空）
 @param orderNamesArray 排序字段数组
 @param asc 是否升序
 @return 查询的内容
 */
-(NSMutableArray *)queryData:(id)object andOrderNames:(NSArray *)orderNamesArray andIsASC:(BOOL)asc;

/**
 *  获取对象属性名称
 *
 *  @param obj   对象
 */
-(NSMutableArray *)getObjectProperty:(NSObject *)obj;


@end
