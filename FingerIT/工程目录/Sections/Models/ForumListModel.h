//
//  ForumListModel.h
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumListModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *forumName;
@property (nonatomic, strong) NSNumber *viewCount;
@property (nonatomic, strong) NSNumber *replyCount;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *topicUrl;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)ForumListModelWithDic:(NSDictionary *)dic;
@end
