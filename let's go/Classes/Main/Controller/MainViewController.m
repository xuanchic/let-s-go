//
//  MainViewController.m
//  let's go
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "TabBar.h"
#import "LogginViewController.h"
#import "ImageViewController.h"
#import "MediaViewController.h"
#import "ProfileViewController.h"
#import "PlusViewController.h"
#import "imageController.h"

@interface MainViewController ()<TabBarDelegate>


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self tapEnjoyAction];
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    LogginViewController *vcLoggin = [[LogginViewController alloc] init];
    [self addViewController:vcLoggin imageName:@"Detail_Btn_readmodelOff" title:@"日志"];
    ImageViewController *vcImage = [[ImageViewController alloc] init];
    [self addViewController:vcImage imageName:@"Notifi_Follow_Newspaper" title:@"图语"];
    MediaViewController *vcMedia = [[MediaViewController alloc] init];
    [self addViewController:vcMedia imageName:@"Invited" title:@"记忆"];
    ProfileViewController *vcPro = [[ProfileViewController alloc] init];
    [self addViewController:vcPro imageName:@"circle_fans" title:@"个人"];
    
    TabBar *tabBar = [[TabBar alloc] init];
    tabBar.tintColor = [UIColor orangeColor];
    tabBar.tintAdjustmentMode = YES;
    tabBar.delegates = self;
    tabBar.barTintColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    [self setValue:tabBar forKey:@"tabBar"];
    //self.tabBar.barTintColor = [UIColor clearColor];
}

- (void)addViewController:(UIViewController *)Controller imageName:(NSString *)imageName title:(NSString *)title
{
    Controller.tabBarItem.image = [UIImage imageNamed:imageName];
    Controller.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Night",imageName]];
    Controller.title = title;
    Controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
   
    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:Controller];
    vcNav.navigationBar.translucent = NO;
    
    
    [self addChildViewController:vcNav];
    
}

- (void)tabBarDidClickPlusButton:(TabBar *)tabbar
{
    //判断是否登录

    [self showSchoolList:tabbar];
}

- (void)showSchoolList:(UITabBar *)tabbar
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionText = [UIAlertAction actionWithTitle:@"发日志" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PlusViewController *plusVc = [[PlusViewController alloc] init];
        UINavigationController *naviga = [[UINavigationController alloc]initWithRootViewController:plusVc];
        [self presentViewController:naviga animated:YES completion:nil];
    }];
    UIAlertAction *acitonImage = [UIAlertAction actionWithTitle:@"发图文" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imageController *imgVc = [[imageController alloc] init];
        UINavigationController *naviga = [[UINavigationController alloc] initWithRootViewController:imgVc];
        [self presentViewController:naviga animated:YES completion:nil];
    }];
//    UIAlertAction *actionMedia = [UIAlertAction actionWithTitle:@"发视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        mediaController *medVc = [[mediaController alloc] init];
//        UINavigationController *navgia = [[UINavigationController alloc] initWithRootViewController:medVc];
//        [self presentViewController:navgia animated:YES completion:nil];
//    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:actionText];
    [alert addAction:acitonImage];
//    [alert addAction:actionMedia];
    [alert addAction:actionCancle];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tapEnjoyAction
{
    // 保存版本号
    // NSUserDefaults:单例, 用法类似NSDictionary 就是能把信息存储到Bundle中的一个plist文件中
    NSString *strVersion = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults]setObject:strVersion forKey:@"oldVersionKey"];
    // 强制现在就写入plist
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
@end
