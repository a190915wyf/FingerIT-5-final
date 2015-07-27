//
//  MarkViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MarkViewController.h"
#import "CommonMacro.h"
#import "MBProgressHUD.h"
@interface MarkViewController ()<UIAlertViewDelegate>

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:133 / 255.0 blue:36 / 255.0 alpha:1.0];
    [self addViews];
}
- (void)addViews {
    UIImageView *aView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 3 / 8, 20, kScreenWidth / 4, kScreenWidth / 4)];
    aView.image = [UIImage imageNamed:@"mark"];
    [self.view addSubview:aView];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"亲~, 指尖IT城体验效果还好么?😋" message:@"" delegate:self cancelButtonTitle:@"稍后再评分" otherButtonTitles:@"用户体验非常好, 5分好评", @"用户体验较好, 4分好评", @"用户体验一般, 3分中评", @"用户体验不好, 2分差评", @"用户体验极差, 1分差评",  nil];
    [alert show];
 }

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
    if (buttonIndex < 2 &&buttonIndex > 0) {
        HUD.labelText = [NSString stringWithFormat:@"您为我打了%ld分, 谢谢鼓励!", (long)(6 - buttonIndex)];
    } else if (buttonIndex < 6&& buttonIndex != 0) {
        HUD.labelText = [NSString stringWithFormat:@"您为我打了%ld分, 我会继续努力的😊!", (long)(6 - buttonIndex)];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    HUD.center = CGPointMake(kScreenWidth / 4, kScreenHeight / 2);
    HUD.labelFont = [UIFont systemFontOfSize:14];
    HUD.dimBackground = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
    [self.view addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];

    }];
    


 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
