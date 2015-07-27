//
//  DBHelper.m
//  iCoderZhiShi
//
//  Created by lanouhn on 15/6/11.
//  Copyright (c) 2015年 赵阿申. All rights reserved.
//

#import "DBHelper.h"
#import "FMDB.h"
#import "FavouriteModel.h"
@implementation DBHelper

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
    [db executeUpdate:@"create table if not exists t_favorite(zId integer primary key autoincrement, title text, url text, aImage text)"];
    [db close];
}
//插入一条收藏信息
+ (BOOL)insertData:(FavouriteModel *)model {
    [self createTable];
    [self openDataBase];
    //处理为空
    if ([model.title isEqualToString:@""]) {
        return NO;
    }
    FMResultSet *rs = [db executeQuery:@"select * from t_favorite where title=?", model.title];
    //已经存在
    if ([rs next]) {
        [rs close];
        [db close];
        return NO;
    } else {
        [db executeUpdate:@"insert into t_favorite(title, url, aImage) values(?, ?, ?)", model.title, model.url, model.aImage];
        [db close];

        return YES;
    }
    
}
//删除一条收藏信息
+ (void)deleteData:(NSInteger)fid {
    [self openDataBase];
    [db executeUpdate:@"delete from t_favorite where zId=?",[NSString stringWithFormat:@"%ld", (long)fid]];
    [db close];
}
//返回查询数据结果
+ (NSMutableArray *)getListData {
    [self createTable];
    [self openDataBase];
    NSMutableArray *listArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_favorite"];
    while ([rs next]) {
        FavouriteModel *model = [[FavouriteModel alloc] init];
        NSInteger zId = [rs intForColumn:@"zId"];
        NSString *title = [rs stringForColumn:@"title"];
        NSString *url = [rs stringForColumn:@"url"];
        NSString *aImage = [rs stringForColumn:@"aImage"];
        model.zId = zId;
        model.title = title;
        model.url = url;
        model.aImage = aImage;
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
