//
//  DBHelperTwo.h
//  FingerIT
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FavouriteModelTwo;

@interface DBHelperTwo : NSObject

//插入收藏数据
+ (BOOL)insertData:(FavouriteModelTwo *)model;
//删除收藏数据
+ (void)deleteData:(NSInteger)fid;
//获取列表
+ (NSMutableArray *)getListData;

@end
