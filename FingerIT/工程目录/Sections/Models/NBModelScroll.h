//
//  NBModelScroll.h
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBModelScroll : NSObject
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *hitUrl;

- (id)initWithDic:(NSDictionary *)dic;
+ (id)NBModelScrollWithDic:(NSDictionary *)dic;

@end
