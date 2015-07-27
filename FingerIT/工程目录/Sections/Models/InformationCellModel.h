//
//  InformationCellModel.h
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationCellModel : NSObject
@property (nonatomic, strong) NSString *image;//cell图片
@property (nonatomic, strong) NSString *title;//cell标题
@property (nonatomic, strong) NSString *pubDate;//出版日期
@property (nonatomic, strong) NSNumber *cmtCount;//评论数
@property (nonatomic, strong) NSString *url;//cell网址

-  (id)initWithDictionary:(NSDictionary *)dic;
+ (id)informationCellModelWithDictionary:(NSDictionary *)dic;
@end
