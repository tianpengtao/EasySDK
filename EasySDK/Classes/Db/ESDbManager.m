//
//  ESDbManager.m
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//

#import "ESDbManager.h"
#import "FMDB.h"
@interface ESDbManager()
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;

@end
@implementation ESDbManager
+(instancetype)manager{
  static dispatch_once_t pred;
  static ESDbManager *sharedInstance = nil;
  
  dispatch_once(&pred, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}
-(instancetype)init{
  self=[super init];
  if (self) {
    
  }
  return self;
}

/**
 执行sql，增、删、改
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 执行是否成功
 */
- (BOOL)execSql:(NSString *)sql
           args:(NSArray*)args
         dbPath:(NSString*)dbPath
{
  __block BOOL isSucess = NO;
  FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
  [dbQueue inDatabase:^(FMDatabase *db)
   {
     isSucess = [db executeUpdate:sql withArgumentsInArray:args] ;
   }];
  return isSucess;
}

/**
 执行多条sql，增、删、改，使用事务提升性能
 
 @param sqls sqls语句，?作为占位符
 @param args 参数、二维数组
 @param dbPath 数据库路径
 @return 执行是否成功
 */
- (BOOL)execSqls:(NSArray*)sqls
            args:(NSArray*)args
          dbPath:(NSString*)dbPath
{
  FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
  [queue inTransaction:^(FMDatabase *db, BOOL *rollback)
   {
     for (int i=0; i<[sqls count]; i++)
     {
      BOOL isSucess = [db executeUpdate:sqls[i] withArgumentsInArray:args[i]];
       if (!isSucess) {
         *rollback=YES;
         NSLog(@"sql:%@ 执行失败",sqls[i]);
       }
     }
   }];
  return YES;
}

/**
 执行sql，查
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 查询结果
 */
- (NSArray*)searchSql:(NSString *)sql
                 args:(NSArray*)args
               dbPath:(NSString*)dbPath
{
  NSMutableArray *resultArray = [[NSMutableArray alloc] init];
  
  FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
  [queue inDatabase:^(FMDatabase *db)
   {
     FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:args];
     while ([rs next])
     {
       [resultArray addObject:rs.resultDictionary];
     }
   }];
  return resultArray;
}

/**
 table是否存在
 
 @param tableName 表名
 @param dbPath 数据库路径
 @return 查询结果
 */
- (BOOL)tableExists:(NSString *)tableName
             dbPath:(NSString *)dbPath
{
  __block BOOL isExists=NO;
  FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
  [queue inDatabase:^(FMDatabase *db)
   {
     isExists = [db tableExists:tableName];
   }];
  return isExists;
}

/**
 查询记录条数
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 记录条数
 */
- (NSInteger)rowsSql:(NSString*)sql
                args:(NSArray*)args
              dbPath:(NSString*)dbPath
{
  __block NSInteger rows=0;
  FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
  [queue inDatabase:^(FMDatabase *db)
   {
     FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:args];
     while ([rs next]) {
       rows = [rs intForColumnIndex:0];
     }
   }];
  return rows;
}
@end
