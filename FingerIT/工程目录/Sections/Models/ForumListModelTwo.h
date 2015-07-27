//
//  ForumListModelTwo.h
//  FingerIT
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumListModelTwo : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *view;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *uri;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)ForumListModelTwoWithDic:(NSDictionary *)dic;

@end
