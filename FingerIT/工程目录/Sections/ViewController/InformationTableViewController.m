//
//  InformationTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "InformationTableViewController.h"
#import "CommonMacro.h"
#import "InformationModel.h"
#import "InformationCellModel.h"
#import "MJRefresh.h"
#import "SecondTableViewCell.h"
#import "DetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailsViewController.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "SetTableViewController.h"
#import "AFNetworking.h"
#import "ThemeTableViewController.h"
#import "MBProgressHUD.h"
@interface InformationTableViewController () <UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isOnce;
@property (nonatomic, strong) InformationCellModel *model;
@property (nonatomic, strong) NSMutableArray *dataSourceScroll;//存储轮播图
@property (nonatomic, strong) NSMutableArray *dataSourceArr;//存储每一条资讯
@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) NSArray *topArr;
@property (nonatomic, strong) NSArray *sortArr;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic, assign) NSInteger index;//存储topBtn的tag值
@property (nonatomic, strong) UIImageView *imaView;
@property (nonatomic, strong) UIScrollView *scroll1;

@property (nonatomic, strong) UIScrollView *scroll2;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) NSArray *cellModelArr;
@property (nonatomic, strong) UIScrollView *redView;

@end

@implementation InformationTableViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArr;
}
- (NSMutableArray *)dataSourceScroll {
    if (!_dataSourceScroll) {
        self.dataSourceScroll = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceScroll;
}
#pragma mark - 数据请求
- (void)requestData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName = [NSString stringWithFormat:kInformationUrl, self.sortArr[_index - 101], (long)self.number];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSDictionary *dic = responseObject;
                //存储轮播图
                NSArray *resultScroll = dic[@"focus"];
                //存储每一条资讯
                NSArray *resultCell = dic[@"articleList"];
                if (self.index  == 101) {
                    for (NSDictionary *dic in resultScroll) {
                        InformationModel *model = [InformationModel informationModelWithDictionary:dic];
                        [self.dataSourceScroll addObject:model];
                    }
                }
                
                for (NSDictionary *dic in resultCell) {
                    InformationCellModel *model = [InformationCellModel informationCellModelWithDictionary:dic];
                    [self.dataSourceArr addObject:model];
                }
                
                //创建cellModel数组
                self.cellModelArr = @[self.dataSourceArr[1], self.dataSourceArr[9],self.dataSourceArr[12],self.dataSourceArr[15],self.dataSourceArr[18]];
                for (int i = 0; i < 5; i++) {
                    if (self.index != 101) {
                        InformationCellModel *model = _cellModelArr[i];
                        UIImageView *iView = (UIImageView *)[self.scroll2 viewWithTag:300 + i];
                        [iView sd_setImageWithURL:[NSURL URLWithString:model.image]];
                        
                    }else {
                        InformationModel *model = self.dataSourceScroll[i];
                        UIImageView *iView = (UIImageView *)[self.scroll2 viewWithTag:300 + i];
                        [iView sd_setImageWithURL:[NSURL URLWithString:model.image]];
                    }
                    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(handleSet:)];
    
    self.number = 1;
    self.index = 101;
    self.sortArr = @[@"999", @"4", @"2", @"120", @"3", @"200", @"300", @"301", @"400", @"500"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:127 / 255.0 blue:0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(handleRefresh:)];
    [self requestData];
    [self addAllViews];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:@"SecondCell"];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        //上拉刷新, 下拉加载
    __block InformationTableViewController *VC = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [VC.dataSourceArr removeAllObjects];
        VC.isOnce = NO;
        VC.number = 1;
        [VC requestData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        VC.number++;
        VC.isOnce = YES;
        [VC requestData];
    }];
}
#pragma mark - handle action
- (void)handleSet:(UIBarButtonItem *)item {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    YRSideViewController *sideVC = [delegate sideViewController];
    SetTableViewController *setVC = [[SetTableViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:setVC];
    sideVC.leftViewController = navigationVC;
    sideVC.needSwipeShowMenu = NO;
    [sideVC showLeftViewController:YES];
}
- (void)handletap:(UITapGestureRecognizer *)tap {
    self.tabBarController.tabBar.hidden = YES;
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    detailVC.type = @"新闻";
    NSInteger n = self.scroll2.contentOffset.x / kScreenWidth;
    if (self.index != 101) {
        InformationCellModel *cellModel = _cellModelArr[n];
        detailVC.portStr = cellModel.url;
    } else {
        InformationModel *model = self.dataSourceScroll[n];
        detailVC.portStr = model.url;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (self.index != 110) {
        UIButton *previousBtn = (UIButton *)[[self.navigationController.view viewWithTag:200] viewWithTag:self.index];
        previousBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.index++;
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame = CGRectMake(0 + kScreenWidth * (self.index - 101) / 5 , kHeight_tableView / 5 - 2, kScreenWidth / 5, 2);
        }];
        if (self.index > 103) {
            [_scroll1 setContentOffset:CGPointMake(kScreenWidth * (self.index - 103) / 5, 0) animated:YES];
        }
        
        UIButton *currentBtn = (UIButton *)[[self.navigationController.view viewWithTag:200] viewWithTag:self.index];
        currentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [currentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    [self.dataSourceArr removeAllObjects];
    [self requestData];
}
- (void)handleRightSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (self.index != 101) {
        UIButton *previousBtn = (UIButton *)[[self.navigationController.view viewWithTag:200] viewWithTag:self.index];
        previousBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.index--;
        [UIView animateWithDuration:0.5 animations:^{
            self.redView.frame = CGRectMake(0 + kScreenWidth * (self.index - 101) / 5 , kHeight_tableView / 5 - 2, kScreenWidth / 5, 2);
        }];
        if (self.index < 108) {
            [_scroll1 setContentOffset:CGPointMake(kScreenWidth * (self.index - 101) / 5, 0) animated:YES];
        }
        UIButton *currentBtn = (UIButton *)[[self.navigationController.view viewWithTag:200] viewWithTag:self.index];
        currentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [currentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    [self.dataSourceArr removeAllObjects];
    [self requestData];
}

- (void)handleTopBtn:(UIButton *)btn {
    [UIView animateWithDuration:0.5 animations:^{
        self.redView.frame = CGRectMake(0 + kScreenWidth * (btn.tag - 101) / 5 , kHeight_tableView / 5 - 2, kScreenWidth / 5, 2);
    }];
    if (self.index != btn.tag) {
        UIButton *previousBtn = (UIButton *)[[self.navigationController.view viewWithTag:200] viewWithTag:self.index];
        previousBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (btn.tag > 103) {
        [_scroll1 setContentOffset:CGPointMake(kScreenWidth * (btn.tag - 103) / 5, 0) animated:YES];
    }
    
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.dataSourceArr removeAllObjects];
    self.index = btn.tag;
    [self requestData];
}

- (void)handlePage:(UIPageControl *)page {
    [self.scroll2 setContentOffset:CGPointMake(page.currentPage * kScreenWidth, 0) animated:YES];
    self.pageCount = page.currentPage;
}

- (void)addTimer {
    if (self.dataSourceScroll.count != 0 && self.cellModelArr.count != 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
}

- (void)handleTimer {
    [self.scroll2 setContentOffset:CGPointMake(self.pageCount * kScreenWidth, 0) animated:YES];
    self.page.currentPage = self.pageCount;
    if (self.index != 101) {
        InformationCellModel *model = _cellModelArr[self.pageCount];
        self.label.text = model.title;
    } else {
        InformationModel *model = self.dataSourceScroll[self.pageCount];
        self.label.text = model.title;
    }
    
    self.pageCount++;
    if (self.pageCount == 5) {
        self.pageCount = 0;
    }
}

- (void)handleRefresh:(UIBarButtonItem *)item {
    [self.dataSourceArr removeAllObjects];
    [self requestData];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
    HUD.labelText = @"正在刷新";
    HUD.dimBackground = YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        NSUInteger index2 = self.scroll2.contentOffset.x / kScreenWidth;
        if (self.index == 101) {
            if (self.dataSourceScroll.count != 0) {
                InformationModel *model = self.dataSourceScroll[index2];
                self.label.text = model.title;
            }
        } else {
            if (self.cellModelArr.count != 0) {
                InformationCellModel *model = _cellModelArr[index2];
                self.label.text = model.title;
            }
        }
        self.page.currentPage = index2;
        self.pageCount  = index2;
}
-  (void)addAllViews {
    //创建tableHeaderView
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, kHeight_tableView)];
    self.tableView.tableHeaderView = aView;
    self.scroll1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kHeight_tableView / 5)];
    _scroll1.contentSize = CGSizeMake(kScreenWidth * 2, kHeight_tableView / 5);
    _scroll1.tag = 200;
    _scroll1.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:178 / 255.0 blue:238 / 255.0 alpha:1.0];
    [self.navigationController.view addSubview:_scroll1];
    //创建button
    self.topArr = @[@"头条", @"评测", @"新闻", @"DIY", @"导购", @"手机", @"笔记本", @"超极本", @"平板", @"相机"];
    for (int i = 0; i < 10; i++) {
        self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
        _btn.frame = CGRectMake(kScreenWidth / 5 * i, 0, kScreenWidth / 5, kHeight_tableView / 5);
        _btn.tag = 101 + i;
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setTitle:_topArr[i] forState:UIControlStateNormal];
        
        [_btn addTarget:self action:@selector(handleTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll1 addSubview:_btn];
    }
    //创建指示条
    self.redView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , kHeight_tableView / 5 - 2, kScreenWidth / 5, 2)];
    _redView.backgroundColor = [UIColor redColor];
    [self.scroll1 addSubview:_redView];
    //创建scroll2
    self.scroll2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeight_tableView / 5, kScreenWidth, kHeight_tableView * 4 / 5)];
    _scroll2.contentSize = CGSizeMake(kScreenWidth * 5, kHeight_tableView * 4 / 5);
    _scroll2.pagingEnabled = YES;
    _scroll2.backgroundColor = [UIColor purpleColor];
    _scroll2.showsHorizontalScrollIndicator = NO;
    _scroll2.delegate = self;
    [aView addSubview:_scroll2];
    //创建标题label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight_tableView * 5 / 6 - 3, kScreenWidth, kHeight_tableView / 6)];
    _label.font = [UIFont systemFontOfSize:16];
    _label.numberOfLines = 2;
    _label.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    _label.textColor = [UIColor whiteColor];
    [aView addSubview:self.label];
    [aView bringSubviewToFront:self.label];
    //创建pageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth  * 4 / 5 - 5, kHeight_tableView - 10, kScreenWidth / 5, 10)];
    self.page.numberOfPages = 5;
    _page.pageIndicatorTintColor = [UIColor orangeColor];
    _page.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.page addTarget:self action:@selector(handlePage:) forControlEvents:UIControlEventValueChanged];
    [aView addSubview:self.page];
    [aView bringSubviewToFront:self.page];
    [self addTimer];
    //创建轮播图
    for (int i = 0; i < 5; i++) {
        self.imaView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kHeight_tableView * 4 / 5)];
        self.imaView.tag = 300 + i;
        self.imaView.backgroundColor = [UIColor whiteColor];
        //创建轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletap:)];
        [self.imaView addGestureRecognizer:tap];
        //打开imageView的用户交互
        self.imaView.userInteractionEnabled = YES;
        [self.scroll2 addSubview:self.imaView];
    }
    
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
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
    InformationCellModel *model = self.dataSourceArr[indexPath.row];
    [cell configureCellWithInformationCellModel:model];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipe:)];
    leftSwipe.direction =  UISwipeGestureRecognizerDirectionLeft;
    [cell.contentView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
    rightSwipe.direction =  UISwipeGestureRecognizerDirectionRight;
    [cell.contentView addGestureRecognizer:rightSwipe];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMarginTop_CellView * 2 + kHeight_CellView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tabBarController.tabBar.hidden = YES;
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    InformationCellModel *model = self.dataSourceArr[indexPath.row];
    detailVC.portStr = model.url;
    detailVC.bTitle = model.title;
    detailVC.type = @"新闻";
    detailVC.imaUrl = model.image;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    self.scroll1.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    self.scroll1.hidden = NO;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(SecondTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
}
@end
