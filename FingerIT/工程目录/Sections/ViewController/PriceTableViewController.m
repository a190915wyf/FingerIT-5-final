//
//  PriceTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "PriceTableViewController.h"
#import "SecondTableViewCell.h"
#import "InformationCellModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CommonMacro.h"
#import "DetailsViewController.h"
#import "RegionTableViewController.h"
#import "SetTableViewController.h"
#import "AppDelegate.h"
#import "YRSideViewController.h"
#import "AFNetworking.h"

@interface PriceTableViewController () < RegionTableViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *cellModelArr;
@property (nonatomic, strong) UIScrollView *scroll1;
@property (nonatomic, strong) UIScrollView *scroll2;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger number;//pageNumber
@property (nonatomic, strong) NSString *aId;
@end

@implementation PriceTableViewController
#pragma mark - 懒加载
- (void)viewWillAppear:(BOOL)animated {
    [self.dataSourceArr removeAllObjects];
    [self requestData];
    [self.tableView reloadData];
}
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArr;
}
#pragma mark - 请求数据
- (void)requestData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName = [NSString stringWithFormat:kFeaturedUrl, self.aId, (long)self.number];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSDictionary *dic = responseObject;
            //存储每一条资讯
            NSArray *resultCell = dic[@"articleList"];
            for (NSDictionary *dic in resultCell) {
                InformationCellModel *model = [InformationCellModel informationCellModelWithDictionary:dic];
                [self.dataSourceArr addObject:model];
            }
            //创建cellModel数组
            self.cellModelArr = [NSMutableArray arrayWithObjects:self.dataSourceArr[2], self.dataSourceArr[6],self.dataSourceArr[10],self.dataSourceArr[15],self.dataSourceArr[18], nil];
            for (int i = 0; i < 5; i++) {
                InformationCellModel *model = _cellModelArr[i];
                UIImageView *iView = (UIImageView *)[self.scroll2 viewWithTag:600 + i];
                [iView sd_setImageWithURL:[NSURL URLWithString:model.image]];
            }
            
            [self.tableView.footer endRefreshing];
            [self.tableView.header endRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(handleSet:)];

    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = kScreenHeight  / 5;
    [self addViews];
    self.aId = @"100000";
    self.number  = 1;
    [self setupRefresh];
   [self requestData];
    [self addTimer];
}
#pragma mark - add action
- (void) addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }

- (void)addViews {
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight_tableView / 5, kScreenWidth, kHeight_tableView)];
    
    self.scroll1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeight_tableView * 4 / 5, kScreenWidth, kHeight_tableView / 5)];
    _scroll1.backgroundColor = [UIColor colorWithRed:135 / 255.0 green:206 / 255.0 blue:250 / 255.0 alpha:1.0];
    
    UILabel *regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth / 4, kHeight_tableView / 5)];
    regionLabel.text = @"💻各地行情";
    regionLabel.font = [UIFont systemFontOfSize:14];
    [self.scroll1 addSubview:regionLabel];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.frame =CGRectMake(kScreenWidth * 5 / 6 - 5, 2, kScreenWidth / 6, kHeight_tableView / 5 - 4);
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _rightBtn.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    _rightBtn.layer.cornerRadius = 5;
    _rightBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.rightBtn setTitle:@"全国" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(handleRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll1 addSubview:_rightBtn];
    
    self.scroll2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight_tableView * 4 / 5)];
    _scroll2.contentSize = CGSizeMake(kScreenWidth * 5, kHeight_tableView * 4 / 5);
    _scroll2.pagingEnabled = YES;
    _scroll2.showsHorizontalScrollIndicator = NO;
    _scroll2.delegate = self;
    //创建轮播图
    for (int i = 0; i < 5; i++) {
        UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kHeight_tableView * 4 / 5)];
            imaView.tag = 600 + i;
        //创建轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imaView addGestureRecognizer:tap];
        //打开imageView的用户交互
        imaView.userInteractionEnabled = YES;
        [self.scroll2 addSubview:imaView];
        [bView addSubview:_scroll1];
        [bView addSubview:_scroll2];
        self.tableView.tableHeaderView = bView;

        
        //添加label
        self.pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 5 / 6,  kHeight_tableView * 4 / 5 - 20, kScreenWidth / 6, 20)];
        _pageLabel.font = [UIFont systemFontOfSize:16];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.textColor = [UIColor blackColor];
        [self.tableView addSubview:_pageLabel];
        
        UILabel *featureLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, kHeight_tableView * 4 / 5 - 25, kScreenWidth / 4, 20)];
        featureLabel.font = [UIFont systemFontOfSize:14];
        featureLabel.backgroundColor = [UIColor colorWithRed:135 / 255.0 green:206 / 255.0 blue:250 / 255.0 alpha:1.0];
        featureLabel.layer.cornerRadius = 10;
        featureLabel.layer.masksToBounds = YES;
        featureLabel.text = @"👍精品推荐";
        [self.tableView addSubview:featureLabel];
 }
    
}


#pragma mark - handle action
- (void)handleSet:(UIBarButtonItem *)item {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideVC = [delegate sideViewController];
    SetTableViewController *setVC = [[SetTableViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:setVC];
    sideVC.leftViewController = navigationVC;
    [sideVC showLeftViewController:YES];
}
- (void)handleRightBtn:(UIButton *)btn {
    RegionTableViewController *regionVC = [[RegionTableViewController alloc] init];
    //代理传值第三 四步 指定代理对象, 服从协议
    regionVC.delegate = self;
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:regionVC];
    navigationVC.modalTransitionStyle = 1;
    [self presentViewController:navigationVC animated:YES completion:nil];

}
- (void)handleTimer {
    [_scroll2 setContentOffset:CGPointMake(_pageCount * kScreenWidth, 0) animated:YES];
    self.pageCount++;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/5", (long)_pageCount];
    if (_pageCount == 5) {
        self.pageCount = 0;
    }
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    self.tabBarController.tabBar.hidden = YES;
    NSInteger n = _scroll2.contentOffset.x / kScreenWidth;
    InformationCellModel *model = self.cellModelArr[n];
    DetailsViewController *detailVC  =[[DetailsViewController alloc] init];
    detailVC.portStr = model.url;
    detailVC.type = @"新闻";
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - RegionTableViewControllerDelegate
//代理传值第五步 实现协议中的方法
- (void)passValue:(NSMutableArray *)arr {
    [self.rightBtn setTitle:arr[0] forState:UIControlStateNormal];
    self.aId = arr[1];
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
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    InformationCellModel *model = self.dataSourceArr[indexPath.row];
    [cell configureCellWithInformationCellModel:model];
    switch ([[[NSUserDefaults standardUserDefaults] valueForKey:@"themeFlag"] integerValue]) {
        case 0:
            cell.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.pubDateLabel.textColor = [UIColor blackColor];
            cell.cmtCountLabel.textColor = [UIColor blackColor];
            
            break;
        case 1:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.pubDateLabel.textColor = [UIColor whiteColor];
            cell.cmtCountLabel.textColor = [UIColor whiteColor];
            break;
        case 2:
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.pubDateLabel.textColor = [UIColor whiteColor];
            cell.cmtCountLabel.textColor = [UIColor whiteColor];
            
            break;
        case 3:
            cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:63 / 255.0 alpha:1.0];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.pubDateLabel.textColor = [UIColor whiteColor];
            cell.cmtCountLabel.textColor = [UIColor whiteColor];
            
            break;
        case 4:
            cell.backgroundColor = [UIColor colorWithRed:147 / 255.0 green:112 / 255.0 blue:219 / 255.0 alpha:1.0];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.pubDateLabel.textColor = [UIColor whiteColor];
            cell.cmtCountLabel.textColor = [UIColor whiteColor];
            
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tabBarController.tabBar.hidden = YES;
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    InformationCellModel *model = self.dataSourceArr[indexPath.row];
    detailVC.portStr = model.url;
    detailVC.bTitle = model.title;
    detailVC.type = @"新闻";
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)setupRefresh {
    //添加下拉刷新功能
    //[self.tableView addHeaderWithTarget:self action:@selector(downRefresh)];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    //添加上拉加载的功能
    [self.tableView  addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(upRefresh)];
    // [self.tableView addFooterWithTarget:self action:@selector(upRefresh)];
    
}

- (void)downRefresh {
    //把状态设置为下拉刷新状态
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isDown"];
    [self.dataSourceArr removeAllObjects];
    [self.cellModelArr removeAllObjects];
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
