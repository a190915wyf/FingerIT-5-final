//
//  ForumListTableViewController.h
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumListTableViewController : UITableViewController
@property (nonatomic,strong) NSString *aId;//每一个论坛广场网址
@property (nonatomic,strong) NSString *url;//每一个论坛广场网址
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,assign) NSInteger indexRow;

@end
