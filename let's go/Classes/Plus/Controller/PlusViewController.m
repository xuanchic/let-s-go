//
//  PlusViewController.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PlusViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import <AVOSCloud.h>
@interface PlusViewController ()

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIButton *sendBtn;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *strTime;

@property (nonatomic, strong) NSString *strid;

@property (nonatomic, strong) NSString *strNicheng;

@property (nonatomic, strong) NSData *datIcon;

@end

@implementation PlusViewController

- (void)viewWillAppear:(BOOL)animated
{
    AVQuery *que = [AVQuery queryWithClassName:@"people"];
    [que findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (NSDictionary *dic in objects) {
            self.strNicheng = dic[@"nicheng"];
            self.datIcon  = dic[@"icon"];
        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
//    self.view.alpha = 0.15;
    self.navigationController.navigationBar.translucent = NO;
    [self loadDefaultSetting];
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
    style:UIBarButtonItemStylePlain
    target:self
    action:@selector(didBack)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didOK)];
       self.navigationItem.rightBarButtonItem = btnRight;
    
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    self.textField = textField;
    [textField setPlaceholder:@"标题"];
    textField.borderStyle = UITextBorderStyleLine;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(15);
        make.leading.mas_equalTo(self.view).offset(15);
        make.trailing.mas_equalTo(self.view).offset(-15);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    textView.layer.borderColor = UIColor.grayColor.CGColor;
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    self.textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField.mas_bottom).offset(8);
        make.leading.mas_equalTo(textField);
        make.trailing.mas_equalTo(textField);
//        make.height.mas_equalTo(450);
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sendBtn];
    self.sendBtn = sendBtn;
    sendBtn.layer.cornerRadius = 5;
    sendBtn.layer.masksToBounds = YES;
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[UIColor lightGrayColor]];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).offset(20);
        make.trailing.mas_equalTo(textView);
        make.bottom.mas_equalTo(self.view).offset(-10);
        make.width.mas_equalTo(140);
//        make.height.mas_equalTo(45);
    }];
    [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];

}

- (void)send
{
    self.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    //把数据保存到服务器
    AVObject *sendInfo = [AVObject objectWithClassName:@"peopleInfo"];
    [sendInfo setObject:self.username forKey:@"myname"];
    [sendInfo setObject:self.textField.text forKey:@"title"];
    [sendInfo setObject:self.strNicheng forKey:@"nicheng"];
    [sendInfo setObject:self.datIcon forKey:@"icon"];
    [sendInfo setObject:self.textView.text forKey:@"text"];
    [sendInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self didBack];
        }else{
            NSLog(@"%@",error.userInfo);
            UIAlertController *alerFalse = [UIAlertController alertControllerWithTitle:nil message:@"发送失败,请重新尝试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionFalse = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            
            [alerFalse addAction:actionFalse];
            [self presentViewController:alerFalse animated:YES completion:nil];
        }
    }];
}

- (void)didBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        AppDelegate *delegat = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegat loadMainController];
    }];
    
}


-(void)didOK
{
  [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
