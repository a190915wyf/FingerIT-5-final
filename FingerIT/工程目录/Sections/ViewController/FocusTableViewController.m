//
//  FocusTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FocusTableViewController.h"
#import "ForumTableViewCell.h"
#import "CommonMacro.h"
#import "FavouriteModelTwo.h"
#import "DBHelperTwo.h"
#import "DetailsViewController.h"

@interface FocusTableViewController ()
@property (nonatomic, strong) NSMutableArray *forumArr;

@end

@implementation FocusTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView reloadData];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}




- (NSMutableArray *)forumArr {
    if (!_forumArr) {
        self.forumArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _forumArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的论坛";
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = kScreenHeight / 5;
    [self readDataByDB];

    
}
- (void)readDataByDB {
    self.forumArr = [DBHelperTwo getListData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.forumArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FavouriteModelTwo *model = self.forumArr[indexPath.row];
    cell.forumLabel.text = model.title;
    cell.forumLabel.numberOfLines = 0;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    switch ([[[NSUserDefaults standardUserDefaults] valueForKey:@"themeFlag"] integerValue]) {
        case 0:
            cell.backgroundColor = [UIColor whiteColor];
            cell.forumLabel.textColor = [UIColor blackColor];
            self.tableView.backgroundColor = [UIColor whiteColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
            self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 3:
            cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
            self.tableView.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        case 4:
            cell.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
            self.tableView.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
            cell.forumLabel.textColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FavouriteModelTwo *model = self.forumArr[indexPath.row];
    [DBHelperTwo deleteData:model.zId];
    [self.forumArr removeObject:model];
    [self.tableView reloadData];
}

//修改cell默认删除按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath :( NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FavouriteModelTwo *model = self.forumArr[indexPath.row];
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    detailVC.portStr = model.url;
    detailVC.type = @"论坛";
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
