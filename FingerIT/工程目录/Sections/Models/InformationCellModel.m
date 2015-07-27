//
//  InformationCellModel.m
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "InformationCellModel.h"

@implementation InformationCellModel
- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (id)informationCellModelWithDictionary:(NSDictionary *)dic {
    return [[InformationCellModel alloc] initWithDictionary:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
