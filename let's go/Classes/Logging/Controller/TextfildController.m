//
//  TextfildController.m
//  let's go
//
//  Created by qingyun on 16/8/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TextfildController.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface TextfildController ()
@property (nonatomic, weak) UITextView *comment;
@end

@implementation TextfildController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UITextView *Comment = [[UITextView alloc] init];
    [self.view addSubview:Comment];
    self.comment = Comment;
    Comment.layer.borderColor = UIColor.grayColor.CGColor;
    Comment.layer.borderWidth = 1;
    Comment.layer.cornerRadius = 5;
    Comment.layer.masksToBounds = YES;
    
    [Comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.leading.mas_equalTo(self.view).offset(8);
        make.trailing.mas_equalTo(self.view).offset(-8);
        make.height.mas_equalTo(400);
    }];
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnSend];
    btnSend.layer.cornerRadius = 5;
    btnSend.layer.masksToBounds = YES;
    [btnSend setTitle:@"发送评论" forState:UIControlStateNormal];
    [btnSend setBackgroundColor:[UIColor lightGrayColor]];
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Comment.mas_bottom).offset(50);
        make.trailing.mas_equalTo(Comment.mas_trailing).offset(-15);
        make.width.mas_equalTo(145);
    
    }];
    
    [btnSend addTarget:self action:@selector(BlockComment:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)BlockComment:(UIButton *)sendComment
{
    
    if (_blockComment) {
        _blockComment(_comment.text);
        __weak typeof(self) weakSelf = self;
        [weakSelf removeFromParentViewController];
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
