//
//  ForumSquareModel.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumSquareModel.h"

@implementation ForumSquareModel
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (id)ForumSquareModelWithDic:(NSDictionary *)dic {
    return [[ForumSquareModel alloc] initWithDic:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
