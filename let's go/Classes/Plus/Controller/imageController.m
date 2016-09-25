//
//  imageController.m
//  let's go
//
//  Created by qingyun on 16/8/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "imageController.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TZImagePickerController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface imageController ()<UITextViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UIButton * addButton;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSData *datIcon;
@property (nonatomic, strong) NSString *strNicheng;
@property (nonatomic, weak) UIView *views;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, strong) NSMutableArray *choseimage;
@end

@implementation imageController

- (NSMutableArray *)choseimage
{
    if (_choseimage == nil) {
        _choseimage = [NSMutableArray array];
    }
    return _choseimage;
}

- (NSMutableArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray arrayWithCapacity:self.choseimage.count];
        for (UIImage *image in _choseimage) {
            NSData *data = UIImageJPEGRepresentation(image, 0.3);
            [_imageArr addObject:data];
        }
    }
    return _imageArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    AVQuery *que = [AVQuery queryWithClassName:@"people"];
    [que findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (NSDictionary *dic in objects) {
            self.datIcon = dic[@"icon"];
            self.strNicheng = dic[@"nicheng"];
        }
        [self loadImages:self.choseimage forView:self.views];

    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor= [UIColor colorWithRed:244.0/255 green:244.0/255 blue:244.0/255 alpha:1];
    
}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UIBarButtonItem *leftIetm = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didBack)];
    self.navigationItem.leftBarButtonItem = leftIetm;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(didOK)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITextView *textView = [[UITextView alloc] init];
    [self.view addSubview:textView];
    self.textView = textView;
    textView.font = [UIFont systemFontOfSize:15];
    textView.layer.borderColor = UIColor.grayColor.CGColor;
    textView.layer.cornerRadius = 5;
    textView.layer.borderWidth = 1;
    textView.layer.masksToBounds = YES;
//    textView.text = @"请输入你想说的话...";
    textView.textColor = [UIColor blackColor];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(8);
        make.leading.mas_equalTo(self.view).offset(8);
        make.trailing.mas_equalTo(self.view).offset(-8);
        make.height.mas_equalTo(150);
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).offset(8);
        make.width.and.height.mas_equalTo(50);
        make.leading.mas_equalTo(textView);
    }];
    [btn addTarget:self action:@selector(pressClose) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *views = [[UIView alloc] init];
    [self.view addSubview:views];
    self.views = views;
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn.mas_bottom).offset(8);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (void)loadImages:(NSArray *)arrs forView:(UIView *)view {
    // 清除之前添加的所有的ImageView
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = arrs.count;
    NSInteger lineCount= 3;
    CGFloat space = 8;
    CGFloat width = (WIDTH - 4 * space) / lineCount;
    CGFloat height = width;
    //设置图片
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = arrs[index];
        CGFloat X = space + (index % lineCount) * (width + space);
        CGFloat Y = space + (index / lineCount) * (height + space);
        imageView.frame = CGRectMake(X, Y, width, height);
        [view addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [images addObject:imageView.image];
    }
    
}

- (void)pressClose
{
    TZImagePickerController *imagePickVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    //让禁止调用视频
    imagePickVc.sortAscendingByModificationDate = NO;
    [imagePickVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //获取照片后赋值给头像
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.choseimage addObjectsFromArray:photos];
        });
    }];
    
    [self presentViewController:imagePickVc animated:YES completion:nil];
}

- (void)didBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didOK
{
    //数据存储到服务器
        AVObject *imgText = [AVObject objectWithClassName:@"imgText"];
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        [imgText setObject:self.textView.text forKey:@"title"];
        [imgText setObject:userName forKey:@"myname"];
        [imgText setObject:self.strNicheng forKey:@"nicheng"];
        [imgText setObject:self.datIcon forKey:@"icon"];
        [imgText setObject:self.imageArr forKey:@"pics"];
        [imgText saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self didBack];
            }else {
                //发送失败
                UIAlertController *alerFalse = [UIAlertController alertControllerWithTitle:nil message:@"发送失败,请重新尝试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionFalse = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
                
                [alerFalse addAction:actionFalse];
                [self presentViewController:alerFalse animated:YES completion:nil];
            }
        }];
        

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
