//
//  InformationModel.h
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject
@property (nonatomic, strong) NSString *image;//轮播图
@property (nonatomic, strong) NSString *title;//轮播图标题
@property (nonatomic, strong) NSString *url;//轮播图网址


- (id)initWithDictionary:(NSDictionary *)dic;
+ (id)informationModelWithDictionary:(NSDictionary *)dic;
@end
