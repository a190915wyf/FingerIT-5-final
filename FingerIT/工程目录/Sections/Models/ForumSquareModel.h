//
//  ForumSquareModel.h
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumSquareModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *view;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *createAt;
@property (nonatomic, strong) NSString *uri;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)ForumSquareModelWithDic:(NSDictionary *)dic;
@end
