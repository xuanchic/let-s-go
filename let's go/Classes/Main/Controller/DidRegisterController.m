//
//  DidRegisterController.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DidRegisterController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PeopleController.h"

@interface DidRegisterController ()
@property (nonatomic, weak) UITextField *email;
@property (nonatomic, weak) UITextField *userName;
@property (nonatomic, weak) UITextField *passWord;
@property (nonatomic, weak) UITextField *rePassWord;

@end

@implementation DidRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.navigationController.navigationBarHidden = NO;
}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
//    UIColor *color = [UIColor colorWithRed:229/255 green:249/255 blue:250/255 alpha:1];
    self.view.backgroundColor = [UIColor lightTextColor];
    
    UITextField *email = [[UITextField alloc] init];
    email.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:email];
    self.email = email;
    email.backgroundColor = [UIColor whiteColor];
    email.layer.cornerRadius = 5;
    email.placeholder = @"请输入邮箱";
    [email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(70);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(220);
    }];
    
    UITextField *name = [[UITextField alloc] init];
    name.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:name];
    self.userName = name;
    name.backgroundColor = [UIColor whiteColor];
    name.layer.cornerRadius = 5;
    name.placeholder = @"请输入账号";
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(email.mas_bottom).offset(30);
        make.centerX.mas_equalTo(email);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(220);
    }];
    
    UITextField *passWord = [[UITextField alloc] init];
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passWord];
    self.passWord = passWord;
    passWord.backgroundColor = [UIColor whiteColor];
    passWord.placeholder = @"请输入密码";
    passWord.layer.cornerRadius = 5;
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name.mas_bottom).offset(30);
        make.centerX.mas_equalTo(name);
        make.height.mas_equalTo(name);
        make.width.mas_equalTo(name);
    }];
    
    UITextField *rePassWord = [[UITextField alloc] init];
    rePassWord.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:rePassWord];
    self.rePassWord = rePassWord;
    rePassWord.backgroundColor = [UIColor whiteColor];
    rePassWord.placeholder = @"请再次输入密码";
    rePassWord.layer.cornerRadius = 5;
    [rePassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passWord.mas_bottom).offset(30);
        make.centerX.mas_equalTo(passWord);
        make.height.mas_equalTo(passWord);
        make.width.mas_equalTo(passWord);
    }];
    
    UIButton *btnLogin= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnLogin];
    btnLogin.layer.cornerRadius = 5;
    btnLogin.layer.masksToBounds = YES;
    [btnLogin setTitle:@"完成" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLogin setBackgroundColor:[UIColor orangeColor]];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rePassWord).offset(80);
        make.width.mas_equalTo(220);
        make.centerX.mas_equalTo(rePassWord);
        make.height.mas_equalTo(40);
    }];
    [btnLogin addTarget:self action:@selector(goIn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goIn
{
    if ([self.userName.text isEqualToString:@""] || [self.passWord.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入用户名或密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actionCanle];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_passWord.text.length < 6) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"密码长度需不少于六位" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionCanle];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }else {
        if ([self.rePassWord.text isEqualToString:self.passWord.text]) {
            AVUser *user = [[AVUser alloc] init];
            user.username = self.userName.text;
            user.password = self.passWord.text;
            user.email = self.email.text;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                    [def setObject:user.username forKey:@"username"];
                    [def setObject:user.password forKey:@"password"];
                    [def setObject:user.email forKey:@"email"];
                    [def synchronize];
                    
                    PeopleController *people = [[PeopleController alloc] init];
                    [self.navigationController pushViewController:people animated:YES];
                }else {
//                    NSLog(@"%@",error);
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请重新确认密码" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alert addAction:actionCanle];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
