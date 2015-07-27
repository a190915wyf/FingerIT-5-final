//
//  InformationModel.m
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "InformationModel.h"
//@property (nonatomic, strong) NSString *scrollImage;//轮播图
//@property (nonatomic, strong) NSString *scrollTitle;//轮播图标题
//@property (nonatomic, strong) NSString *scrollUrl;//轮播图网址
//@property (nonatomic, strong) NSString *cellImage;//cell图片
//@property (nonatomic, strong) NSString *cellTitle;//cell标题
//@property (nonatomic, strong) NSString *pubDate;//出版日期
//@property (nonatomic, strong) NSString *cmtCount;//评论数
//@property (nonatomic, strong) NSString *cellUrl;//cell网址

@implementation InformationModel
//重写初始化方法, 给InformationModel对象赋值
- (id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
           }
    if (![[self.image substringFromIndex:self.image.length - 1] isEqualToString:@"g"]) {
        NSString *newImage = [self.image stringByAppendingString:@"g"];
        self.image = newImage;
    }
    return self;
}

+ (id)informationModelWithDictionary:(NSDictionary *)dic {
    return [[InformationModel alloc] initWithDictionary:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

@end
