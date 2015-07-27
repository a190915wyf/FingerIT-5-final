//
//  DetailsViewController.m
//  FingerIT
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kHeight_TitleLabel 128
#import "DetailsViewController.h"
#import "CommonMacro.h"
#import "MBProgressHUD.h"
#import <ShareSDK/ShareSDK.h>
#import "FavouriteModel.h"
#import "FavouriteModelTwo.h"
#import "DBHelper.h"
#import "DBHelperTwo.h"
@interface DetailsViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *aView;
@property (nonatomic,strong) NSString *aTitle;
@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic, strong) UIScrollView *scroll1;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic,strong) NSString *nStr;


@end

@implementation DetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.btn.hidden = NO;
    [super viewWillAppear:animated];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
    HUD.labelText = @"正在加载中";
    HUD.dimBackground = YES;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:HUD];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1.0);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];

}
- (void)viewWillDisappear:(BOOL)animated {
    self.btn.hidden = YES;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(handleReply)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fenxiang"]  style:UIBarButtonItemStylePlain target:self action:@selector(handleShare:)];
    [self layoutWebView];
    self.aView.delegate = self;
    if (self.portStr.length == 0) {
        [self showImage];
    } else {
        /*
        if ([self.type isEqualToString:@"新闻"]) {
            NSArray *arr1 = [self.portStr componentsSeparatedByString:@"pconline.com.cn"];
            self.nStr = [ @"http://g.pconline.com.cn" stringByAppendingString:arr1.lastObject];
            [self.aView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.nStr]]];

        }
         */
       // else {
            [self.aView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.portStr]]];
        NSLog(@"%@", self.portStr);
       // }
        
    }
}



- (void)handleReply {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleShare:(UIBarButtonItem *)item {
    id<ISSContent> publishContent = [ShareSDK content:self.portStr
                                       defaultContent:@"测试一下"
                                                image:nil
                                                title:@"我的分享"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithBarButtonItem:item arrowDirect:UIPopoverArrowDirectionUp];
    
    //2、弹出分享菜单
    [ShareSDK showShareActionSheet:container shareList:nil content:publishContent statusBarTips:YES authOptions:nil  shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"  message:nil delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                }  else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                    message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                            }];
}
- (void)layoutWebView {
    
    self.aView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 100)];
    _aView.backgroundColor = [UIColor clearColor];
    _aView.scalesPageToFit = YES;
    _aView.scrollView.bounces = NO;
    [self.view addSubview:_aView];
    //创建textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.editable = NO;
    [self.view addSubview:_textView];
    
    
    //创建收藏按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(kScreenWidth / 7, 32, kScreenWidth / 7, 21);
    [_btn setTitle:@"收藏" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.4];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.layer.cornerRadius = 10;
    [self.navigationController.view addSubview:_btn];
    

}
- (void)showImage {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageV.image = [UIImage imageNamed:@"fail.jpg"];
    [self.view addSubview:imageV];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handleBtn:(UIButton *)item{
    if ([self.type isEqual:@"新闻"]) {
        FavouriteModel *model = [[FavouriteModel alloc] init];
        model.url = self.portStr;
        model.title = self.bTitle;
        model.aImage = self.imaUrl;
        MBProgressHUD *hud =[[MBProgressHUD alloc] init];
        
        [self.view addSubview:hud];

        if ([DBHelper insertData:model]) {
            hud.labelText = @"收藏成功";
            
        } else {
            
            hud.labelText = @"已经收藏";
            
        }
        //置当前的View 为灰色
        hud.dimBackground = YES;
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [hud removeFromSuperview];
        }];
    }
    else {
        FavouriteModelTwo *model = [[FavouriteModelTwo alloc] init];
        model.url = self.portStr;
        model.title = self.bTitle;
        
        MBProgressHUD *hud =[[MBProgressHUD alloc] init];
        
        [self.view addSubview:hud];
        
        if ([DBHelperTwo insertData:model]) {
            hud.labelText = @"收藏成功";
            
        } else {
            
            hud.labelText = @"已经收藏";
            
        }
        //置当前的View 为灰色
        hud.dimBackground = YES;
        hud.mode = MBProgressHUDModeText;
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            [hud removeFromSuperview];
        }];

    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
//CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
    if ([self.type isEqualToString:@"新闻"]) {
        _textView.hidden = NO;
        if ([self.str rangeOfString:@"上一页"].location !=  NSNotFound) {
            NSArray *arr = [self.str componentsSeparatedByString:@"上一页"];
            _textView.text = arr.firstObject;
        }
        else if([self.str rangeOfString:@"文章分享到"].location !=  NSNotFound){
            NSArray *arr = [self.str componentsSeparatedByString:@"文章分享到"];
            _textView.text = arr.firstObject;
        }
        else if([self.str rangeOfString:@"分享到"].location !=  NSNotFound){
            NSArray *arr = [self.str componentsSeparatedByString:@"分享到"];
            _textView.text = arr.firstObject;
        }
        NSArray *bArr = [_textView.text componentsSeparatedByString:@"APP"];
        _textView.text = bArr.lastObject;
    }
    else  if ([self.type isEqualToString:@"论坛"]){
        _textView.hidden = NO;
        NSArray *arr = [self.str componentsSeparatedByString:@"收藏 分享"];
        if ([arr.lastObject containsString:@"上一页"]) {
            NSArray *arr1 = [arr.lastObject componentsSeparatedByString:@"上一页"];
            _textView.text = arr1.firstObject;
        } else if([arr.lastObject containsString:@"请您先登录后发表评论"]) {
            NSArray *arr1 = [arr.lastObject componentsSeparatedByString:@"请您先登录后发表评论"];
            _textView.text = arr1.firstObject;
        }
    }
    else {
        _textView.hidden = YES;
    }
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    //self.aTitle = [self.aView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.str = [self.aView stringByEvaluatingJavaScriptFromString:@"document.body.innerText"];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    return YES;
//}



@end
