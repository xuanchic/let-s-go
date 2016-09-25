//
//  VedioDataController.m
//  let's go
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "VedioDataController.h"
#import "WMPlayer.h"
#import "Masonry.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHight [UIScreen mainScreen].bounds.size.height

@interface VedioDataController ()

@property (nonatomic, strong) WMPlayer *wmPlayer;

@end

@implementation VedioDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self loadDefaultSetting];
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    CGFloat y = kDeviceHight / 3.0 - 0.5 * (kDeviceHight / 3.0);
    
    WMPlayer *wmplayer = [[WMPlayer alloc] initWithFrame:CGRectMake(0, y, kDeviceWidth, kDeviceWidth)];
    wmplayer.URLString = self.urlStr;
    [self.view addSubview:wmplayer];
    
    wmplayer.closeBtn.hidden = YES;
    
    [wmplayer.player play];
    _wmPlayer = wmplayer;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(10);
        make.leading.mas_equalTo(self.view).offset(8);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(45);
    }];
    
    [btn addTarget:self action:@selector(dissmissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dissmissBtnClick:(UIButton *)sender {
    
    [_wmPlayer.player pause];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
