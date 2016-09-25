//
//  ProfileViewController.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProfileViewController.h"
#import "SVProgressHUD.h"
#import "ClearCacheTool.h"
#import "PeopleController.h"
#import "FindpassWord.h"
#import "LogRegistController.h"

#define filePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)firstObject]

@interface ProfileViewController ()

@property (nonatomic, copy) NSArray *arrTitle;
@property (nonatomic, strong) NSString *username;

@end

@implementation ProfileViewController

- (NSArray *)arrTitle
{
    if (_arrTitle == nil) {
        _arrTitle = @[@"个人信息",@"清理缓存",@"注销登录",@"找回密码",@"关于我们"];
    }
    return _arrTitle;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (self.username == nil) {
        UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(didLogin)];
        self.navigationItem.rightBarButtonItem = btnRight;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.arrTitle[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self infoOfpeople];
    }else if (indexPath.row == 1) {
       [self putBufferBtnClicked:indexPath];
    }else if (indexPath.row == 2) {
        [self Logout];
    }else if (indexPath.row == 3) {
        [self findPassword];
    }else{
        [self aboutUs];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)infoOfpeople
{
    PeopleController *peoVc = [[PeopleController alloc] init];
    [self.navigationController pushViewController:peoVc animated:YES];
}

- (void)putBufferBtnClicked:(NSIndexPath *)indexPath
{
    NSString *fileSize = [ClearCacheTool getCacheSizeWithFilePath:filePath];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"清除缓存(%@)",fileSize] preferredStyle:UIAlertControllerStyleActionSheet];
    //创建一个取消和一个确定按钮
    UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //清楚缓存
        BOOL isSuccess = [ClearCacheTool clearCacheWithFilePath:filePath];
        if (isSuccess) {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
    //将取消和确定按钮添加进弹框控制器
    [alert addAction:actionCanle];
    [alert addAction:actionOK];
    //添加一个文本框到弹框控制器
    //显示弹框控制器
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)Logout
{
    if (self.username == nil) {
       
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:@"未登录，无需注销" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [aler addAction:action];
        [self presentViewController:aler animated:YES completion:nil];
        
    }else {
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        [userD removeObjectForKey:@"username"];
        [userD removeObjectForKey:@"password"];
        
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:nil message:@"已成功注销" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [aler addAction:action];
        [self presentViewController:aler animated:YES completion:nil];
        [self viewWillAppear:YES];
        
    }
}

- (void)didLogin
{
    LogRegistController *login = [[LogRegistController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)findPassword
{
    FindpassWord *findword = [[FindpassWord alloc] init];
    [self.navigationController pushViewController:findword animated:YES];
}

- (void)aboutUs
{
    NSString *strMess = @"随意的说吧、随心的拍吧，随时随地的关注吧！这是一款可以让你释放内心的软件!";
    UIAlertController *alerUs = [UIAlertController alertControllerWithTitle:nil message:strMess preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    [alerUs addAction:actionCanle];
    [self presentViewController:alerUs animated:YES completion:nil];
}



@end
