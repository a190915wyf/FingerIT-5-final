//
//  DBHelperTwo.m
//  FingerIT
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DBHelperTwo.h"
#import "FMDB.h"
#import "FavouriteModelTwo.h"

@implementation DBHelperTwo
static FMDatabase *db;
//打开数据库
+ (void)openDataBase {
    db = [FMDatabase databaseWithPath:[self getHomePath:@"ZhijianDB.sqlite"]];
    if (![db open]) {
        return;
    }
    //为数据库设置缓存，提高性能
    [db setShouldCacheStatements:YES];
}

//创建收藏表
+ (void)createTable {
    //判断表是否创建
    [self openDataBase];
    [db executeUpdate:@"create table if not exists t_favoritetwo(zId integer primary key autoincrement, title text, url text)"];
    [db close];
}
//插入一条收藏信息
+ (BOOL)insertData:(FavouriteModelTwo *)model {
    [self createTable];
    [self openDataBase];
    //处理为空
    if ([model.title isEqualToString:@""]) {
        return NO;
    }
    FMResultSet *rs = [db executeQuery:@"select * from t_favoritetwo where title=?", model.title];
    //已经存在
    if ([rs next]) {
        [rs close];
        [db close];
        return NO;
    } else {
        [db executeUpdate:@"insert into t_favoritetwo(title, url) values(?, ?)", model.title, model.url];
        [db close];
        
        return YES;
    }
    
}
//删除一条收藏信息
+ (void)deleteData:(NSInteger)fid {
    [self openDataBase];
    [db executeUpdate:@"delete from t_favoritetwo where zId=?",[NSString stringWithFormat:@"%ld", (long)fid]];
    [db close];
}
//返回查询数据结果
+ (NSMutableArray *)getListData {
    [self createTable];
    [self openDataBase];
    NSMutableArray *listArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_favoritetwo"];
    while ([rs next]) {
        FavouriteModelTwo *model = [[FavouriteModelTwo alloc] init];
        NSInteger zId = [rs intForColumn:@"zId"];
        NSString *title = [rs stringForColumn:@"title"];
        NSString *url = [rs stringForColumn:@"url"];
        model.zId = zId;
        model.title = title;
        model.url = url;
        [listArr addObject:model];
    }
    [rs close];
    [db close];
    return listArr;
}
+ (NSString *)getHomePath:(NSString *)databaseName {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:databaseName];
}

@end
