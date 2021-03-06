//
//  FindpassWord.m
//  let's go
//
//  Created by qingyun on 16/8/24.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FindpassWord.h"
#import "Masonry.h"
#import <AVOSCloud/AVOSCloud.h>

@interface FindpassWord ()
@property (nonatomic, weak) UITextField *phone;
@property (nonatomic, weak) UITextField *xinPwd;
@property (nonatomic, weak) UITextField *xinRePwd;
@property (nonatomic, weak) UITextField *yanNum;
@property (nonatomic, weak) UIButton *btnYan;
@property (nonatomic, strong) NSTimer *time;
@property (nonatomic, assign) NSInteger countdown;

@end

@implementation FindpassWord

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UITextField *phone = [[UITextField alloc] init];
    [self.view addSubview:phone];
    self.phone = phone;
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.placeholder = @"请输入邮箱";
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(80);
        make.leading.mas_equalTo(self.view).offset(30);
        make.trailing.mas_equalTo(self.view).offset(-100);
    }];
    
//    UIButton *btnYan = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btnYan];
//    self.btnYan = btnYan;
//    
//    btnYan.layer.cornerRadius = 5;
//    btnYan.layer.masksToBounds = YES;
//    btnYan.titleLabel.font = [UIFont systemFontOfSize:13];
//    [btnYan setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [btnYan setBackgroundColor:[UIColor whiteColor]];
//    [btnYan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btnYan mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(phone.mas_trailing).offset(10);
//        make.trailing.mas_equalTo(self.view).offset(-8);
//        make.centerY.mas_equalTo(phone);
//    }];
//    [btnYan addTarget:self action:@selector(getYan) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UITextField *yanNum = [[UITextField alloc] init];
//    [self.view addSubview:yanNum];
//    self.yanNum = yanNum;
//    yanNum.borderStyle = UITextBorderStyleRoundedRect;
//    yanNum.placeholder = @"请输入验证码";
//    [yanNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(phone.mas_bottom).offset(20);
//        make.leading.mas_equalTo(phone);
//        make.trailing.mas_equalTo(self.view).offset(-18);
////        make.width.mas_equalTo(phone);
//    }];
//    
//    UITextField *xinPass = [[UITextField alloc] init];
//    [self.view addSubview:xinPass];
//    self.xinPwd = xinPass;
//    [xinPass setSecureTextEntry:NO];
//    xinPass.borderStyle = UITextBorderStyleRoundedRect;
//    xinPass.placeholder = @"请输入新密码";
//    [xinPass mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(yanNum.mas_bottom).offset(40);
//        make.centerX.mas_equalTo(yanNum);
//        make.width.mas_equalTo(yanNum);
//    }];
//    
//    UITextField *xinRePass = [[UITextField alloc] init];
//    [self.view addSubview:xinRePass];
//    self.xinRePwd = xinRePass;
//    [xinPass setSecureTextEntry:NO];
//    xinRePass.borderStyle = UITextBorderStyleRoundedRect;
//    xinRePass.placeholder = @"请再次输入新密码";
//    [xinRePass mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(xinPass.mas_bottom).offset(20);
//        make.centerX.mas_equalTo(xinPass);
//        make.width.mas_equalTo(xinPass);
//    }];
    
    UIButton *btnOk = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnOk];
    btnOk.layer.cornerRadius = 5;
    btnOk.layer.masksToBounds = YES;
    [btnOk setTitle:@"确认" forState:UIControlStateNormal];
    [btnOk setBackgroundColor:[UIColor lightGrayColor]];
    [btnOk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phone.mas_bottom).offset(35);
        make.leading.mas_equalTo(phone.mas_trailing).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(45);
    }];
    [btnOk addTarget:self action:@selector(postInfo) forControlEvents:UIControlEventTouchUpInside];
}


//- (void)getYan
//{
//    NSString *strPhone = self.phone.text;
//   
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:strPhone zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"获取验证码");
//            //让btn上的标题变成倒计时
//            [self openCountdown];
//        }else {
//            NSLog(@"%@",error);
//        }
//    }];
//}

- (void)openCountdown
{
     _countdown = 59;
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    [_btnYan setTitle:[NSString stringWithFormat:@"%lds",(long)_countdown] forState:UIControlStateNormal];
    _btnYan.userInteractionEnabled = NO;
    
    
}
- (void)timeFireMethod
{
    _countdown --;
    [_btnYan setTitle:[NSString stringWithFormat:@"%lds",(long)_countdown] forState:UIControlStateNormal];
    if (_countdown < 0) {
        [_btnYan setTitle:@"获取验证码" forState:UIControlStateNormal];
        _btnYan.userInteractionEnabled = YES;
        [_time invalidate];
    }
}

- (void)postInfo
{
     NSString *strPhone = self.phone.text;
//     NSString *strYan = self.yanNum.text;
    [AVUser requestPasswordResetForEmailInBackground:strPhone block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请进入邮箱重置" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"输入有误或是网络有异常，请重新尝试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:actionOk];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
//    [SMSSDK commitVerificationCode:strYan phoneNumber:strPhone zone:@"86" result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"提交成功");
//            AVUser *currentUser = [AVUser currentUser];
//            NSString *strId = currentUser.objectId;
//            AVObject *todo =[AVObject objectWithClassName:@"_User" objectId:strId];
//            [todo setObject:self.xinPwd.text forKey:currentUser.password];
//            // 保存到云端
//            [todo saveInBackground];
//        
//            
//            } else {
//                
//                }
//    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
