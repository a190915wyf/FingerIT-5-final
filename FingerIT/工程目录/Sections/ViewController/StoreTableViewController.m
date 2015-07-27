//
//  StoreTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#import "AppDelegate.h"
#import "StoreTableViewController.h"
#import "ForumTableViewCell.h"
#import "FavouriteModel.h"
#import "DBHelper.h"
#import "DetailsViewController.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"
@interface StoreTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation StoreTableViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView reloadData];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = kScreenHeight / 5;
    [self readDataByDB];


}


#pragma  mark - 数据类
- (void)readDataByDB {
    
    self.dataSource = [DBHelper getListData];
}



#pragma mark -action



#pragma  mark - lazying load
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
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
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FavouriteModel *model = self.dataSource[indexPath.row];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.forumLabel.text = model.title;
    UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(5, kScreenHeight / 30, kScreenWidth * 2 / 5, kScreenHeight * 2 / 15)];
    [ima sd_setImageWithURL:[NSURL URLWithString:model.aImage]];
    [cell addSubview:ima];
    CGRect frame = cell.forumLabel.frame;
    frame.origin.x = kScreenWidth * 2 / 5 + 10;
    frame.origin.y = kScreenHeight / 30;
    frame.size.width =kScreenWidth * 3 / 5 - 40;
    cell.forumLabel.frame = frame;
    
    cell.forumLabel.numberOfLines = 0;
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
    FavouriteModel *model = self.dataSource[indexPath.row];
    [DBHelper deleteData:model.zId];
    [self.dataSource removeObject:model];
    [self.tableView reloadData];
}

//修改cell默认删除按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath :( NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FavouriteModel *model = self.dataSource[indexPath.row];
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    detailVC.portStr = model.url;
    detailVC.type = @"新闻";
    [self.navigationController pushViewController:detailVC animated:YES];

}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
