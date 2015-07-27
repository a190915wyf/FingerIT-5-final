//
//  NBModelTwo.h
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBModelTwo : NSObject

@property (nonatomic,strong) NSString *picUrl;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *saleNum;
@property (nonatomic,strong) NSString *nowPrice;
@property (nonatomic,strong) NSString *priceMarket;
@property (nonatomic, strong) NSString *tuanUrl;

@property (nonatomic,strong) NSNumber *day;
@property (nonatomic,strong) NSNumber *hour;
@property (nonatomic,strong) NSNumber *minute;
@property (nonatomic,strong) NSNumber *second;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)NBModelTwoWithDic:(NSDictionary *)dic;

@end
