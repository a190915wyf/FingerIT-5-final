//
//  AppDelegate.m
//  FingerIT
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "CommonMacro.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *rootTC = [storyBoard instantiateInitialViewController];
    self.sideViewController = [[YRSideViewController alloc] init];
    _sideViewController.rootViewController = rootTC;
    _sideViewController.leftViewShowWidth = kScreenWidth  * 2 / 3;
    self.window.rootViewController = self.sideViewController;
    [self shareAction];
    return YES;
}

- (void)shareAction {
    [ShareSDK registerApp:@"4a88b2fb067c"];
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com wdl@pmmq.com 此处需要替换成自己应用的
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
        [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                               appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                               wechatCls:[WXApi class]];
        [ShareSDK connectWhatsApp];
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
    [ShareSDK importWeChatClass:[WXApi class]];
}

- (BOOL)application: (UIApplication *)application  handleOpenURL: (NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}
- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
    return [ShareSDK handleOpenURL: url
                 sourceApplication:sourceApplication
                        annotation: annotation
                        wxDelegate: self];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
