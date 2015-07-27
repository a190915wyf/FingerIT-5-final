//
//  ThemeTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "ForumTableViewCell.h"
#import "CommonMacro.h"
@interface ThemeTableViewController ()
@property (nonatomic, strong) NSMutableArray *themeArr;
@end

@implementation ThemeTableViewController

- (NSMutableArray *)themeArr {
    if (!_themeArr) {
        self.themeArr = [NSMutableArray arrayWithObjects:@"💎白色", @"💙蓝色", @"❤️红色", @"🌰棕色", @"💜紫色",   nil];
    }
    return _themeArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主题列表";
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = kScreenHeight / 5;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.themeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.forumLabel.text = self.themeArr[indexPath.row];
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
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"themeFlag"];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"themeFlag"];
            [self.navigationController popViewControllerAnimated:YES];

            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"themeFlag"];
            [self.navigationController popViewControllerAnimated:YES];

            break;
        case 3:
            [[NSUserDefaults standardUserDefaults] setValue:@"3" forKey:@"themeFlag"];
            [self.navigationController popViewControllerAnimated:YES];

            break;
        case 4:
            [[NSUserDefaults standardUserDefaults] setValue:@"4" forKey:@"themeFlag"];
            [self.navigationController popViewControllerAnimated:YES];

            break;
        default:
            return;
            break;
    }

}


@end
