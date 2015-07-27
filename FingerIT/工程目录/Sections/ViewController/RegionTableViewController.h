//
//  RegionTableViewController.h
//  FingerIT
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理传值第一步 定义协议
@protocol RegionTableViewControllerDelegate <NSObject>

- (void)passValue:(NSMutableArray *)arr;
@end







@interface RegionTableViewController : UITableViewController
//第二步 定义代理属性
@property (nonatomic, assign) id<RegionTableViewControllerDelegate>delegate;

@end
