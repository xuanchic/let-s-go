//
//  RegisterController.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LogRegistController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "DidRegisterController.h"
#import "MainViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface LogRegistController ()

@property (nonatomic, weak) UITextField *userName;
@property (nonatomic, weak) UITextField *passWord;
@property (nonatomic, weak) UIButton *btnLogin;

@end

@implementation LogRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    if (name != nil && pwd != nil) {
        [self tapEnjoyAction];
    };
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    self.view.backgroundColor = [UIColor lightTextColor];
    
    UITextField *name = [[UITextField alloc] init];
    name.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:name];
    self.userName = name;
    name.backgroundColor = [UIColor whiteColor];
    name.layer.cornerRadius = 5;
    name.placeholder = @"请输入账号";
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(120);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(220);
    }];
    
    UITextField *passWord = [[UITextField alloc] init];
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passWord];
    self.passWord = passWord;
    passWord.backgroundColor = [UIColor whiteColor];
    passWord.placeholder = @"请输入密码";
    passWord.secureTextEntry = YES;
    passWord.layer.cornerRadius = 5;
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(30);
        make.centerX.mas_equalTo(name);
        make.height.mas_equalTo(name);
        make.width.mas_equalTo(name);
    }];
    
    UIButton *btnLogin= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnLogin];
    self.btnLogin = btnLogin;
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.masksToBounds = YES;
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin setBackgroundColor:[UIColor orangeColor]];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passWord).offset(80);
        make.width.mas_equalTo(220);
        make.centerX.mas_equalTo(passWord);
        make.height.mas_equalTo(40);
    }];
    [btnLogin addTarget:self action:@selector(goIn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnRegister];
    btnRegister.layer.cornerRadius = 5;
    btnRegister.layer.masksToBounds = YES;
    [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRegister setBackgroundColor:[UIColor orangeColor]];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnLogin.mas_bottom).offset(30);
        make.width.mas_equalTo(220);
        make.centerX.mas_equalTo(btnLogin.mas_centerX);
        make.height.mas_equalTo(40);
    }];
    [btnRegister addTarget:self action:@selector(didRegister) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnEnter];
    [btnEnter setTitle:@"跳过" forState:UIControlStateNormal];
    [btnEnter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnEnter setBackgroundColor:[UIColor lightTextColor]];
    [btnEnter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnRegister.mas_bottom).offset(8);
        make.trailing.mas_equalTo(btnRegister.mas_trailing).offset(-8);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(40);
        
    }];
    [btnEnter addTarget:self action:@selector(tapEnjoyAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goIn
{
    if (self.userName.text.length == 0 || self.passWord.text.length == 0) {
        UIAlertController *alerc = [UIAlertController alertControllerWithTitle:nil message:@"密码或账号不能为空，请输入" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alerc addAction:actionCanle];
        [self presentViewController:alerc animated:YES completion:nil];
        return;
    }else {
        __weak typeof(self) weakSelf = self;
        [AVUser logInWithUsernameInBackground:self.userName.text password:self.passWord.text block:^(AVUser *user, NSError *error) {
            if (!error) {
                NSUserDefaults *defau = [NSUserDefaults standardUserDefaults];
                [defau setObject:user.username forKey:@"username"];
                [defau setObject:user.password forKey:@"password"];
                [defau synchronize];
                [self tapEnjoyAction];

            }else {
//                NSLog(@"登录失败%@",error);
                UIAlertController *alerc = [UIAlertController alertControllerWithTitle:nil message:@"登录失败，请重新尝试" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alerc addAction:actionCanle];
                [weakSelf presentViewController:alerc animated:YES completion:nil];
                self.userName.text = nil;
                self.passWord.text = nil;
                
            }
        }];
    }
}

- (void)didRegister
{
    DidRegisterController *didRevc = [[DidRegisterController alloc] init];
//    [self presentViewController:didRevc animated:YES completion:nil];
    [self.navigationController pushViewController:didRevc animated:YES];
}

- (void)tapEnjoyAction
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate loadMainController];
}
#pragma mark  > 点击屏幕后编辑结束 <
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
