//
//  ForumTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#import "ForumTableViewController.h"
#import "CommonMacro.h"
#import "ForumTableViewCell.h"
#import "FeaturedTableViewCell.h"
#import "CommonMacro.h"
#import "ForumSquareTableViewController.h"
#import "ForumListTableViewController.h"
#import "MJRefresh.h"
#import "ForumListModel.h"
#import "DetailsViewController.h"
#import "SetTableViewController.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
@interface ForumTableViewController ()
@property (nonatomic, strong) NSMutableArray *forumSquareArr;
@property (nonatomic, strong) NSMutableArray *forumListArr;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, assign) NSInteger n;
@property (nonatomic, strong) NSMutableArray *aIdArr;
@property (nonatomic, strong) NSMutableArray *bIdArr;

@end

@implementation ForumTableViewController
//懒加载
- (NSMutableArray *)forumSquareArr {
    if (!_forumSquareArr) {
        self.forumSquareArr = [NSMutableArray arrayWithObjects:@"DIY攒机交流区", @"DIY极客营",  @"手机综合讨论区", @"手机随拍分享区", @"phone一族", @"笔记本讨论区", @"超极本讨论区", @"二手电脑/配件", @"二手手机", @"二手笔记本", nil];
    }
    return _forumSquareArr;
}

- (NSMutableArray *)forumListArr {
    if (!_forumListArr) {
        self.forumListArr = [NSMutableArray arrayWithObjects:@"DIY论坛", @"手机论坛", @"笔记本论坛", @"平板电脑论坛", @"各地论坛", @"网络论坛", @"家电论坛", @"最数码论坛", nil];
    }

    return _forumListArr;
}
- (NSMutableArray *)aIdArr {
    if (!_aIdArr) {
        self.aIdArr = [NSMutableArray arrayWithObjects:@"721485", @"768253", @"587012", @"675902", @"769285", @"6", @"769002", @"45", @"240027", @"671334", nil];
    }

    return _aIdArr;
}

- (NSMutableArray *)bIdArr {
    if (!_bIdArr) {
        self.bIdArr = [NSMutableArray arrayWithObjects:@"2", @"8", @"240024", @"768687", @"186953", @"588091", nil];
    }
    return _bIdArr;
}
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(handleSet:)];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //创建分段式控件
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"论坛广场", @"论坛列表", @"每日精选"]];
    _seg.frame = CGRectMake(kScreenWidth / 5, 32, kScreenWidth * 3 / 5, 32);
    _seg.selectedSegmentIndex = 0;
    [_seg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [_seg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];

    _seg.tintColor = [UIColor colorWithRed:30 / 255.0 green:144 / 255.0 blue:1.0 alpha:1.0];
    
    [_seg addTarget:self action:@selector(handleSeg:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _seg;
    
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"firstCell"];
    [self.tableView registerClass:[FeaturedTableViewCell class] forCellReuseIdentifier:@"secondCell"];
    self.tableView.rowHeight = kScreenHeight / 6;
}

#pragma mark - 数据请求
- (void)requestData {
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName =kpickedUrl;
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
        [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (responseObject != nil) {
                NSDictionary *dic = responseObject;
                NSArray *arr = dic[@"hot-topics"];
                for (NSDictionary *dic in arr) {
                    ForumListModel *model = [ForumListModel ForumListModelWithDic:dic];
                    [self.dataSourceArr addObject:model];
                }
                [self.tableView.footer endRefreshing];
                [self.tableView.header endRefreshing];
                [self.tableView reloadData];
   
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"连接失败, 请检查您的网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"我知道了", nil];
            [alert show];
            [self.refreshControl endRefreshing];
        }];
    }

#pragma mark - handle action
- (void)handleSet:(UIBarButtonItem *)item {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideVC = [delegate sideViewController];
    SetTableViewController *setVC = [[SetTableViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:setVC];
    sideVC.leftViewController = navigationVC;
    sideVC.needSwipeShowMenu = YES;
    [sideVC showLeftViewController:YES];
}

- (void)handleSeg:(UISegmentedControl *)seg {
    [self.dataSourceArr removeAllObjects];
    self.n = seg.selectedSegmentIndex;
    if (self.n == 2) {
        [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
        [self requestData];
    }
    [self.tableView reloadData];
}
- (void)downRefresh {
    [self.dataSourceArr removeAllObjects];
    [self requestData];
    [self.tableView.header endRefreshing];
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
    switch (self.n) {
        case 0:
        return self.forumSquareArr.count;
            break;
        case 1:
            return self.forumListArr.count;
            break;
        default:
            return self.dataSourceArr.count;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.n == 2) {
        FeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        ForumListModel *model = self.dataSourceArr[indexPath.row];
        [cell configureCellWithModel:model];
        switch ([[[NSUserDefaults standardUserDefaults] valueForKey:@"themeFlag"] integerValue]) {
            case 0:
                self.tableView.backgroundColor = [UIColor whiteColor];
                cell.backgroundColor = [UIColor whiteColor];
                cell.titleLabel.textColor = [UIColor blackColor];
                cell.forumNameLabel.textColor = [UIColor redColor];
                cell.floorLabel.textColor = [UIColor blackColor];
                cell.timeLabel.textColor = [UIColor blackColor];
                break;
            case 1:
                self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
                cell.titleLabel.textColor = [UIColor whiteColor];
                cell.forumNameLabel.textColor = [UIColor whiteColor];
                cell.floorLabel.textColor = [UIColor whiteColor];
                cell.timeLabel.textColor = [UIColor whiteColor];
                break;
            case 2:
                self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
                cell.titleLabel.textColor = [UIColor whiteColor];
                cell.forumNameLabel.textColor = [UIColor whiteColor];
                cell.floorLabel.textColor = [UIColor whiteColor];
                cell.timeLabel.textColor = [UIColor whiteColor];
                break;
            case 3:
                self.tableView.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
                cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
                cell.titleLabel.textColor = [UIColor whiteColor];
                cell.forumNameLabel.textColor = [UIColor whiteColor];
                cell.floorLabel.textColor = [UIColor whiteColor];
                cell.timeLabel.textColor = [UIColor whiteColor];
                break;
            case 4:
                self.tableView.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
                cell.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
                cell.titleLabel.textColor = [UIColor whiteColor];
                cell.forumNameLabel.textColor = [UIColor whiteColor];
                cell.floorLabel.textColor = [UIColor whiteColor];
                cell.timeLabel.textColor = [UIColor whiteColor];
                break;
            default:
                break;
        }

        return cell;
        
    } else {
        ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (self.n == 0) {
            cell.forumLabel.text = self.forumSquareArr[indexPath.row];

        } else {
            cell.forumLabel.text  = self.forumListArr[indexPath.row];
        }
        switch ([[[NSUserDefaults standardUserDefaults] valueForKey:@"themeFlag"] integerValue]) {
            case 0:
                self.tableView.backgroundColor = [UIColor whiteColor];
                cell.backgroundColor = [UIColor whiteColor];
                cell.forumLabel.textColor = [UIColor blackColor];
                break;
            case 1:
                self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
                cell.forumLabel.textColor = [UIColor whiteColor];
                break;
            case 2:
                self.tableView.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
                cell.forumLabel.textColor = [UIColor whiteColor];
                break;
            case 3:
                self.tableView.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
                cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
                cell.forumLabel.textColor = [UIColor whiteColor];
                break;
            case 4:
                self.tableView.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
                cell.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
                cell.forumLabel.textColor = [UIColor whiteColor];
                break;
            default:
                break;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.seg.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    if (self.n == 0) {
        ForumSquareTableViewController *forumSquareVC = [[ForumSquareTableViewController alloc] init];
        forumSquareVC.aId = self.aIdArr[indexPath.row];
        forumSquareVC.titleLabel.text = self.forumSquareArr[indexPath.row];
        [self.navigationController pushViewController:forumSquareVC animated:YES];

    } else if(self.n == 1) {
        ForumListTableViewController *forumListVC = [[ForumListTableViewController alloc] init];
        if (indexPath.row != 6 && indexPath.row != 7) {
            forumListVC.aId = self.bIdArr[indexPath.row];
        } else if (indexPath.row == 6) {
            forumListVC.flag = 6;
            forumListVC.url = @"http://mrobot.pconline.com.cn/v3/itbbs/newForums/767804?&pageNo=%ld&pageSize=20&orderby=replyat";

        } else {
            forumListVC.flag = 7;
            forumListVC.url = @"http://piebbs.pconline.com.cn/mobile/topics.ajax?type=hot_week&singleForum=false&noForums=22&ie=utf-8&count=100&showImage=true&forums=2";
        }
        forumListVC.titleLabel.text = self.forumListArr[indexPath.row];
        [self.navigationController pushViewController:forumListVC animated:YES];
    } else {
        DetailsViewController *detailVC = [[DetailsViewController alloc] init];
        ForumListModel *model = self.dataSourceArr[indexPath.row];
        detailVC.portStr = model.topicUrl;
        detailVC.bTitle = model.title;
        detailVC.type = @"论坛";
        [self.navigationController pushViewController:detailVC animated:YES];
   }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    _seg.hidden = NO;
}

@end
