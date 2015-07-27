//
//  MineTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MineTableViewController.h"
#import "SetTableViewController.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "ForumTableViewCell.h"
#import "CommonMacro.h"
#import <ShareSDK/ShareSDK.h>
#import "DetailsViewController.h"
#import "StoreTableViewController.h"
#import "ThemeTableViewController.h"
#import "FocusTableViewController.h"
@interface MineTableViewController ()
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) UIView *aView;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(handleSet:)];
    self.arr = [NSMutableArray arrayWithObjects:@"🍄主题设置", @"📦我的收藏", @"👥我的论坛", nil];

    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"mine"];
    self.tableView.rowHeight = kScreenHeight / 6;
    [self addViews];
    self.tableView.tableHeaderView = _aView;
    self.tableView.scrollEnabled = NO;



}

- (void)addViews {
    self.aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight / 3 - 20)];
    UIImageView *bView = [[UIImageView alloc] initWithFrame:_aView.frame];
    bView.image = [UIImage imageNamed:@"computer.jpg"];
    [self.aView addSubview:bView];
    
    
}

- (void)handleSet:(UIBarButtonItem *)item {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideVC = [delegate sideViewController];
    SetTableViewController *setVC = [[SetTableViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:setVC];
    sideVC.leftViewController = navigationVC;
    [sideVC showLeftViewController:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mine" forIndexPath:indexPath];
    cell.forumLabel.text = self.arr[indexPath.row];
    cell.forumLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    switch ([[[NSUserDefaults standardUserDefaults] valueForKey:@"themeFlag"] integerValue]) {
        case 0:
            cell.backgroundColor = [UIColor whiteColor];
            cell.forumLabel.textColor = [UIColor blackColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 4:
            cell.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ThemeTableViewController *ThemeVC = [[ThemeTableViewController alloc] init];
            ThemeVC.modalTransitionStyle = 1;
            [self.navigationController pushViewController:ThemeVC animated:YES];
        }
            break;
        case 1:
        {
            StoreTableViewController *storeVC = [[StoreTableViewController alloc] init];
            [self.navigationController pushViewController:storeVC animated:YES];
        }
            break;
            case 2:
        {
            FocusTableViewController *focusVC = [[FocusTableViewController alloc] init];
                [self.navigationController pushViewController:focusVC animated:YES];
        }
            break;

        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

@end
