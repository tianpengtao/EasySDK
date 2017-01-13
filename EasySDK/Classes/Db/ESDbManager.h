//
//  ESDbManager.h
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESDbManager : NSObject
+(instancetype)manager;

/**
 执行sql，增、删、改
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 执行是否成功
 */
- (BOOL)execSql:(NSString*)sql
           args:(NSArray*)args
         dbPath:(NSString*)dbPath;

/**
 执行多条sql，增、删、改，使用事务提升性能
 
 @param sqls sqls语句，?作为占位符
 @param args 参数，二维数组
 @param dbPath 数据库路径
 @return 执行是否成功
 */
- (BOOL)execSqls:(NSArray*)sqls
            args:(NSArray*)args
          dbPath:(NSString*)dbPath;

/**
 执行sql，查
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 查询结果
 */
- (NSArray*)searchSql:(NSString *)sql
                  args:(NSArray*)args
               dbPath:(NSString*)dbPath;


/**
 table是否存在

 @param tableName 表名
 @param dbPath 数据库路径
 @return 查询结果
 */
- (BOOL)tableExists:(NSString *)tableName
             dbPath:(NSString *)dbPath;

/**
 查询记录条数
 
 @param sql sql语句，?作为占位符
 @param args 参数
 @param dbPath 数据库路径
 @return 记录条数
 */
- (NSInteger)rowsSql:(NSString*)sql
                args:(NSArray*)args
              dbPath:(NSString*)dbPath;
@end
