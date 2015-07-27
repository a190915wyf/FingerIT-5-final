//
//  SetTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SetTableViewController.h"
#import "ForumTableViewCell.h"
#import "CommonMacro.h"
#import "MBProgressHUD.h"
#import "MarkViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@interface SetTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) ForumTableViewCell *cell;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) UIActivityIndicatorView *clean;

@property (nonatomic, strong) UIView *mineView;

@end

@implementation SetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(handleReply:)];
    //设置导航条颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航条字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"set"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight = kScreenHeight / 7;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
    self.dataSourceArr = [NSMutableArray arrayWithObjects:@"🌘夜间模式", @"💿清除缓存", @"😇关于我们", @"👍给我评分",  @"👤免责声明", @"", @"", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - handle action
- (void)handleReply:(UIBarButtonItem *)item {
    AppDelegate *app  = [[UIApplication sharedApplication] delegate];
    YRSideViewController *sideVC =  [app sideViewController];
    [sideVC hideSideViewController:YES];


}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"set" forIndexPath:indexPath];
    _cell.forumLabel.text = self.dataSourceArr[indexPath.row];
    _cell.forumLabel.font = [UIFont systemFontOfSize:16];
    _cell.forumLabel.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, kScreenWidth / 14 + 10, 15, 15)];
    imageView.image = [UIImage imageNamed:@"arrow"];
    [_cell addSubview:imageView];

    _cell.selectedBackgroundView = [[UIView alloc] initWithFrame:_cell.frame];
    _cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    return _cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            switch (self.flag) {
                case 1:{
                    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
                    HUD.labelText = @"夜间模式已关闭";
                    HUD.center = CGPointMake(kScreenWidth / 4, kScreenHeight / 2);
                    HUD.dimBackground = YES;
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
                    [self.tableView addSubview:HUD];
                    [HUD showAnimated:YES whileExecutingBlock:^{
                        sleep(1.0);
                    } completionBlock:^{
                        [HUD removeFromSuperview];
                    }];
                    self.view.window.alpha = 1.0;
                    self.flag = 0;
            }
                    break;
                case 0: {
                    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
                    HUD.labelText = @"夜间模式已打开";
                    HUD.center = CGPointMake(kScreenWidth / 4, kScreenHeight / 2);
                    HUD.dimBackground = YES;
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
                    [self.tableView addSubview:HUD];
                    [HUD showAnimated:YES whileExecutingBlock:^{
                        sleep(1.0);
                    } completionBlock:^{
                        [HUD removeFromSuperview];
                    }];
                    self.view.window.alpha = 0.5;
                    self.flag = 1;
                }
                    break;
                default:
                    break;
            }
            break;

        }
        case 1: {
            [self clearRubbishes];
            break;

        }
        case 2: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"😇关于我们" message:@"作者:斌潮澎湃, 研究领域:iOS开发, 联系方式:972253813@qq.com" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alert show];
    }
            break;
        case 3: {
            MarkViewController *markVC = [[MarkViewController alloc] init];
            [self presentViewController:markVC animated:YES completion:nil];
        }
            break;
        case 4: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"👤免责声明" message:@"本软件可以为用户提供最新最热门的IT类行情信息, 并且可以与网友在贴吧互相交流IT技术, 数据来源于互联网, 最终解释权归个人所有 " delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alert show];

        }
            break;
        default:
            break;
    }
}

//清除缓存方法
- (void)clearCache:(NSString *)path {
    NSString *cachePaht = [self cachesFilePath];
    CGFloat fileSize = [self folderSizeAtPath:cachePaht];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    [self.clean stopAnimating];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"您已经删除了%.2fMB文件😊", fileSize] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] ;
    [alertView show];
    
}

//获取沙盒文件夹下Library下的Cache文件夹路径
- (NSString *)cachesFilePath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return cachePath;
}


//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float)folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//清除缓存触发事件
- (void)clearRubbishes {
    NSString *cachePath;
    cachePath = [self cachesFilePath];
    NSString *message = [NSString stringWithFormat:@"亲,您有%.2fMB的缓存,确定要删除吗?", [self folderSizeAtPath:cachePath]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


#pragma mark - UIAlertViewDelegae
//刚点击按钮触发
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1:
            //风火轮
            [self.clean startAnimating];
            break;
            
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
            
            [self clearCache:[self cachesFilePath]];
            //[self.clean startAnimating];
            break;
            
        case 0:
            
            break;
            
        default:
            break;
    }
}

@end
