//
//  AppDelegate.m
//  let's go
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowViewController.h"
#import "MainViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PlusViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *nav;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] init];
    self.window.rootViewController = nav;
    self.nav = nav;
    
    NSString *strVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *strVersionMain = [[NSUserDefaults standardUserDefaults] objectForKey:@"oldVersionKey"];
    
    if ([strVersion isEqualToString:strVersionMain]) {
        [self loadMainController];
    }else {
//        [self.window setRootViewController:[[ShowViewController alloc] init]];
        ShowViewController *showVc = [[ShowViewController alloc] init];
        [nav pushViewController:showVc animated:YES];
    }
    
    [self.window makeKeyAndVisible];
    //添加leancloud服务器
    [AVOSCloud setApplicationId:@"qnMp7aTgr0qEdCsmnBAtE2Up-gzGzoHsz" clientKey:@"YBHnyyfjv5Y2H4qPfWQ61Y5k"];
    
    //初始化应用，appkey和appSecret从后台申请（短信验证）
//    [SMSSDK registerApp:@"167d739a8c420" withSecret:@"687f48b3b11d94da52aa11366f98536e"];
    

    
    return YES;
}

- (void)loadMainController
{
    [_window setRootViewController:[[MainViewController alloc] init]];
    //初始化client
//    self.client = [[AVIMClient alloc] initWithClientId:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
//   //Clint 上线
//    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            NSLog(@"error");
//        }else {
//            NSLog(@"client open success");
//        }
//    }];
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
