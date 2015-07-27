//
//  ForumSquareTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumSquareTableViewController.h"
#import "ForumTableViewController.h"
#import "UIImageView+WebCache.h"
#import "ForumSquareModel.h"
#import "ForumSquareTableViewCell.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "DetailsViewController.h"
#import "AFNetworking.h"
@interface ForumSquareTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, assign) NSInteger number;//pageNo

@end

@implementation ForumSquareTableViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArr;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 75, 20, 150, 32)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (void)viewWillAppear:(BOOL)animated {
    _titleLabel.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    [self.navigationController.view addSubview:_titleLabel];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(handleReply:)];
    self.number = 1;
    [self.tableView registerClass:[ForumSquareTableViewCell class] forCellReuseIdentifier:@"forumSquareTableViewCell"];
    self.tableView.rowHeight = kScreenHeight / 3;
    [self requestData];

 }
#pragma mark - 加载数据
- (void)requestData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName =[NSString stringWithFormat:kForumSquareUrl, self.aId, (long)self.number];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", @"application/json",nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSDictionary *dic = responseObject;
            NSArray *listArr = dic[@"topicList"];
            for (NSDictionary *dic1 in listArr) {
                ForumSquareModel *model = [ForumSquareModel ForumSquareModelWithDic:dic1];
                [self.dataSourceArr addObject:model];
            }
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"连接失败, 请检查您的网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"我知道了", nil];
        [alert show];
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - handle action
- (void)handleReply:(UIBarButtonItem *)item {
    _titleLabel.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumSquareTableViewCell" forIndexPath:indexPath];
    ForumSquareModel *model = self.dataSourceArr[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    ForumSquareModel *model = self.dataSourceArr[indexPath.row];
    detailVC.portStr = model.uri;
    detailVC.bTitle = model.title;
    detailVC.type = @"论坛";
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)setupRefresh {
    
    //添加下拉刷新功能
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    //添加上拉加载的功能
    [self.tableView  addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    
}

- (void)downRefresh {
    //把状态设置为下拉刷新状态
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isDown"];
    [self.dataSourceArr removeAllObjects];
    self.number = 1;
    [self requestData];
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

- (void)upRefresh {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isDown"] == YES) {
        self.number = 1;
        
    }
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isDown"
     ];
    self.number++;
    [self requestData];
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
}

@end
