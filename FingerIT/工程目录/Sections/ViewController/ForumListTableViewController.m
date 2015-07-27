//
//  ForumListTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumListTableViewController.h"
#import "ForumListTableViewCell.h"
#import "ForumListModel.h"
#import "ForumListModelTwo.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "DetailsViewController.h"
#import "AFNetworking.h"
@interface ForumListTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, assign) NSInteger number;
@end

@implementation ForumListTableViewController
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
-(void)viewWillAppear:(BOOL)animated {
    _titleLabel.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view addSubview:_titleLabel];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(handleReply:)];
    self.number = 1;
    [self setupRefresh];
    [self.tableView registerClass:[ForumListTableViewCell class] forCellReuseIdentifier:@"forumListTableViewCell"];
    self.tableView.rowHeight = 350 * kScreenHeight / 667  ;
    [self requestData];
}
#pragma mark - 请求数据
- (void)requestData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName = @"";
    switch (self.flag) {
        case 6:
            linkName = [NSString stringWithFormat:self.url, self.number];
            break;
            case 7:
            linkName = self.url;
        default:
            linkName = [NSString stringWithFormat:kForumListUrl, self.aId];
            break;
    }
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", @"application/json",nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSDictionary *dic = responseObject;
            NSArray *listArr = dic[@"hot-topics"];
            NSDictionary *nameDic = dic[@"forum"];
            NSArray *listArr3 = dic[@"topicList"];
            if (listArr.count != 0) {
                for (NSDictionary *dic in listArr) {
                    ForumListModel *model = [ForumListModel ForumListModelWithDic:dic];
                    [self.dataSourceArr addObject:model];
                }
            }
            if (listArr3.count != 0) {
                for (NSDictionary *dic in listArr3) {
                    ForumListModelTwo *model = [ForumListModelTwo ForumListModelTwoWithDic:dic];
                    model.name = nameDic[@"name"];
                    [self.dataSourceArr addObject:model];
                }
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumListTableViewCell" forIndexPath:indexPath];
    if (self.flag != 6) {
        ForumListModel *model = self.dataSourceArr[indexPath.row];
        [cell configureCellWithModel:model];
    } else {
        ForumListModelTwo *model = self.dataSourceArr[indexPath.row];
        [cell configureCellWithModelTwo:model];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    detailVC.type = @"论坛";
    if (self.flag == 6) {
        ForumListModelTwo *model = self.dataSourceArr[indexPath.row];
        detailVC.bTitle = model.title;
        detailVC.portStr = model.uri;

    } else {
    ForumListModel *model = self.dataSourceArr[indexPath.row];
    detailVC.portStr = model.topicUrl;
    detailVC.bTitle = model.title;
}
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - handle action
- (void)handleReply:(UIBarButtonItem *)item {
    _titleLabel.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupRefresh {
    
    //添加下拉刷新功能
    //[self.tableView addHeaderWithTarget:self action:@selector(downRefresh)];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    if (self.flag == 6) {
        //添加上拉加载的功能
        [self.tableView  addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    }
    
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
