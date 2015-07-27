//
//  HappyBuyCollectionViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kHappyBuyScrollUrl @"http://api.zol.com/index.php?c=Tuan_AppReturn&a=FocusPic&vs=and391"
#define kHappyBuyItemUrl @"http://api.zol.com/index.php?c=Tuan_AppReturn&a=GoodsList&vs=and391"
#import "HappyBuyCollectionViewController.h"
#import "CommonMacro.h"
#import "NBcell.h"
#import "NBCellTwo.h"
#import "HappyBuyHeaderReusableView.h"
#import "HeaderViewTwo.h"
#import "FooterView.h"
#import "NBModel.h"
#import "NBModelTwo.h"
#import "NBModelScroll.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "DetailsViewController.h"
#import "AFNetworking.h"
#import "YRSideViewController.h"
#import "SetTableViewController.h"
#import "AppDelegate.h"

@interface HappyBuyCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *dataSourceArrTwo;
@property (nonatomic, strong) NSMutableArray *dataSourceScrollArr;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NBCellTwo *cellTwo;
@property (nonatomic, strong) NBModelTwo *modelTwo;

@property (nonatomic, assign) NSInteger second;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger day;

@property (nonatomic, strong) HeaderViewTwo *scrollHeader;
@property (nonatomic, assign) NSInteger pageCount;
@end

@implementation HappyBuyCollectionViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArr;
}
- (NSMutableArray *)dataSourceArrTwo {
    if (!_dataSourceArrTwo) {
        self.dataSourceArrTwo = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArrTwo;
}
- (NSMutableArray *)dataSourceScrollArr {
    if (!_dataSourceScrollArr) {
        self.dataSourceScrollArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceScrollArr;
}
#pragma mark  - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

#pragma mark - 请求数据
- (void)requestScrollData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName = kHappyBuyScrollUrl;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSArray *scrollImageArr = responseObject;
            for (NSDictionary *dic in scrollImageArr) {
                NBModelScroll *model = [NBModelScroll NBModelScrollWithDic:dic];
                [self.dataSourceScrollArr addObject:model];
            }
            for (int i = 0; i < 3; i++) {
                UIImageView *aView = (UIImageView *)[_scrollHeader.scroll viewWithTag:500 + i];
                NBModelScroll *model = self.dataSourceScrollArr[i];
                [aView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
            }
            [self.collectionView.header endRefreshing];
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];

}
- (void)requestData {
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSString *linkName = kHappyBuyItemUrl;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/html", nil];
    [manger GET:linkName parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject != nil) {
            NSArray *arr = responseObject;
            NSArray *subArr1 = [arr subarrayWithRange:NSMakeRange(0, 1)];
            NSArray *subArr2 = [arr subarrayWithRange:NSMakeRange(1, arr.count - 1)];
            for (NSDictionary *dic in subArr1) {
                self.modelTwo = [NBModelTwo NBModelTwoWithDic:dic];
                NSDictionary *dic1 = dic[@"countDown"];
                _modelTwo.day = dic1[@"day"];
                _modelTwo.hour = dic1[@"hour"];
                _modelTwo.minute = dic1[@"minute"];
                _modelTwo.second = dic1[@"second"];
                
                self.second = [_modelTwo.second integerValue];
                self.minute = [_modelTwo.minute integerValue];
                self.hour =  [_modelTwo.hour integerValue];
                self.day = [_modelTwo.day integerValue];
                
                [self.dataSourceArrTwo addObject:_modelTwo];
                
            }
            for (NSDictionary *dic in subArr2) {
                NBModel *model = [NBModel NBModelWithDic:dic];
                [self.dataSourceArr addObject:model];
            }
            [self.collectionView.header endRefreshing];
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];

            }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"连接失败, 请检查您的网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"我知道了", nil];
        [alert show];
        [self.collectionView.header endRefreshing];
        [self.collectionView.footer endRefreshing];
    }];
}

#pragma mark - 加载数据
/*
- (void)networkEngine:(NetworkEngine *)networkEngine requestFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"连接失败, 请检查您的网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"我知道了", nil];
    [alert show];
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
}
 */
#pragma mark - handle action
- (void)addTap {
    for (int i = 0; i < 3; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tap.numberOfTapsRequired = 1;
        UIImageView *aView = (UIImageView *)[_scrollHeader.scroll viewWithTag:500 + i];

        [aView addGestureRecognizer:tap];

    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    self.tabBarController.tabBar.hidden = YES;
    DetailsViewController *detailVC =[[DetailsViewController alloc] init];
    NSInteger n = _scrollHeader.scroll.contentOffset.x / kScreenWidth;
    NBModelScroll *model = self.dataSourceScrollArr[n];
    detailVC.portStr = model.hitUrl;
    detailVC.type = @"开心购";
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)scrollAddTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:YES];
}
- (void)handleScrollTimer {
    
    [_scrollHeader.scroll setContentOffset:CGPointMake(_pageCount * kScreenWidth, 0) animated:YES];
    self.pageCount++;

    if (self.pageCount == 3) {
        self.pageCount = 0;
    }
    
}
- (void)addTimer {
    self.timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
}
- (void)handleTimer {
    if (self.second-- == 0) {
        self.minute--;
        self.second = 59;
    }
    if (self.minute == 0 && self.second == 0) {
        self.hour--;
        self.minute = 59;
        self.second = 59;
    }
    if (self.hour == 0 && self.minute == 0 && self.second == 0) {
        self.day--;
        self.hour = 23;
        self.minute = 59;
        self.second = 59;
    }
    if (self.day == 0&&self.hour == 0 && self.minute == 0 && self.second == 0) {
        _cellTwo.statusLabel.text = @"已结束";
        [self.timer invalidate];
    }
    _cellTwo.statusLabel.text = [NSString stringWithFormat:@"还剩 %ld 天 %ld 时 %ld 分 %ld 秒", (long)self.day, (long)self.hour, (long)self.minute, (long)self.second];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] style:UIBarButtonItemStylePlain target:self action:@selector(handleSet:)];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //5.设置滑动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    //注册item
    [self.collectionView registerClass:[NBcell class] forCellWithReuseIdentifier:@"item"];
    [self.collectionView registerClass:[NBCellTwo class] forCellWithReuseIdentifier:@"itemTwo"];
    //注册页眉
    [self.collectionView registerClass:[HappyBuyHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[HeaderViewTwo class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerScroll"];

    //注册页脚
    [self.collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self requestData];
    [self requestScrollData];
    [self setupRefresh];
    [self addTimer];
    [self scrollAddTimer];
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

#pragma mark - UICollectionViewDataSource
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
//每个分区对应的items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? self.dataSourceArrTwo.count : self.dataSourceArr.count;
 }
//配置相应的items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.cellTwo = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemTwo" forIndexPath:indexPath];
        NBModelTwo *model = self.dataSourceArrTwo[0];
        [self.cellTwo configureNBCellTwoWithModel:model];
        _cellTwo.layer.borderColor=[UIColor lightGrayColor].CGColor;
        _cellTwo.layer.borderWidth= 0.3;
        return _cellTwo;
    } else {
    NBcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    NBModel *model = self.dataSourceArr[indexPath.row];
    [cell configureNBCellWithModel:model];
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cell.layer.borderWidth=0.5;
    if (cell.priceLabelTwo.text.length < 4) {
        UIView *lineView = [cell.priceLabelTwo viewWithTag:1000];
        CGRect frame = lineView.frame;
        frame.size.width = 45;
        lineView.frame = frame;
    }
        return cell;
 }
}
//针对于每个分区的页眉和页脚, 返回对应的视图对象, 重用

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //页眉
        HappyBuyHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.titleLabel.text = @"  👍今日精选";
        return headerView;
    } else {
        FooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footView;
    }
    } else {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            //页眉
            self.scrollHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerScroll" forIndexPath:indexPath];
            [self addTap];
            return _scrollHeader;
        } else {
            FooterView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
            return footView;
        }
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
//动态设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? CGSizeMake(kScreenWidth - 10, kScreenHeight / 4) : CGSizeMake((kScreenWidth - 30) / 2 , kScreenHeight * 2  / 5);
}
//动态设置每个分区的缩进量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return section == 0 ? UIEdgeInsetsMake(5, 5, 0, 5) : UIEdgeInsetsMake(5, 10, 10, 10);
}
//动态设置每个分区的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
//动态设置每个分区的最小item间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
//动态设置每个分区的页眉的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGSizeMake(0, kScreenHeight / 4) : CGSizeMake(0, 30);
}

//动态设置每个分区的页脚的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 1);
    
}

//item选中之后触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.tabBarController.tabBar.hidden = YES;
    DetailsViewController *detailVC = [[DetailsViewController alloc] init];
    detailVC.type = @"开心购";
    if (indexPath.section == 0 ) {
        NBModelTwo *model = self.dataSourceArrTwo[indexPath.row];
        detailVC.portStr = model.tuanUrl;
        detailVC.bTitle = model.goodsName;
    } else {
        NBModel *model = self.dataSourceArr[indexPath.row];
        detailVC.portStr = model.tuanUrl;
        detailVC.bTitle = model.goodsName;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (void)setupRefresh {
    
    //添加下拉刷新功能
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(downRefresh)];
    
}

- (void)downRefresh {
    //把状态设置为下拉刷新状态
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isDown"];
    [self.dataSourceScrollArr removeAllObjects];
    [self.dataSourceArr removeAllObjects];
    [self.dataSourceArrTwo removeAllObjects];
    [self requestData];
    [self requestScrollData];
    [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
}

@end
