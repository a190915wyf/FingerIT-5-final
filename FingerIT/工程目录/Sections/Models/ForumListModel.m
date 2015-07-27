//
//  ForumListModel.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumListModel.h"

@implementation ForumListModel
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (id)ForumListModelWithDic:(NSDictionary *)dic {
    return [[ForumListModel alloc] initWithDic:dic];


}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
