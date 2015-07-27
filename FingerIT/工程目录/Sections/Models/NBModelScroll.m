//
//  NBModelScroll.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NBModelScroll.h"

@implementation NBModelScroll


- (id)initWithDic:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


+ (id)NBModelScrollWithDic:(NSDictionary *)dic {
    return [[NBModelScroll alloc] initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
