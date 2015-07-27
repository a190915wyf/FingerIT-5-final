//
//  ForumListModelTwo.m
//  FingerIT
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumListModelTwo.h"

@implementation ForumListModelTwo
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (id)ForumListModelTwoWithDic:(NSDictionary *)dic {
    return [[ForumListModelTwo alloc] initWithDic:dic];
    
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
