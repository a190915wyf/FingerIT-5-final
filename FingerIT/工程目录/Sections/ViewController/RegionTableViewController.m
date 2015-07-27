//
//  RegionTableViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kRegionUrl @"http://mrobot.pconline.com.cn/v2/cms/channels/%@?pageNo=1&pageSize=20"
#import "RegionTableViewController.h"
#import "ForumTableViewCell.h"
#import "CommonMacro.h"
@interface RegionTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableArray *aIdArr;


@end

@implementation RegionTableViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        self.dataSourceArr = [NSMutableArray arrayWithObjects:@"全国", @"北京", @"上海", @"广州", @"深圳", @"重庆", @"辽宁", @"福建", @"浙江", @"广西", @"成都", @"武汉", @"河北", @"黑龙江", @"西安", @"山东", @"湖南", @"河南", @"江西", @"香港", @"珠海", @"安徽",  @"海南", @"江苏", @"东莞", @"天津", @"宁波", @"佛山", @"大连", @"保定", nil];
    }
    return _dataSourceArr;

}

- (NSMutableArray *)aIdArr {
    if (!_aIdArr) {
        self.aIdArr = [NSMutableArray arrayWithObjects:@"100000", @"110000", @"310000", @"440100", @"440300", @"500000", @"210000", @"350000", @"330000", @"450000", @"510100", @"420100", @"120105", @"230000", @"220403", @"370000", @"430000", @"410000", @"360000", @"810000", @"440400", @"340000", @"460000", @"320000", @"441900", @"120000", @"330200", @"440600", @"210200", @"130600", nil];
    }
    return _aIdArr;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地区列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(handleReply)];
    
    [self.tableView registerClass:[ForumTableViewCell class] forCellReuseIdentifier:@"region"];
    self.tableView.rowHeight = kScreenHeight / 7;
    [self.tableView setSeparatorColor:[UIColor blackColor]];

    
}
- (void)handleReply {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return self.dataSourceArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"region" forIndexPath:indexPath];
    
    cell.forumLabel.text = self.dataSourceArr[indexPath.row];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *regionName = self.dataSourceArr[indexPath.row];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:regionName, self.aIdArr[indexPath.row], nil];
    if ([self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:arr];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
