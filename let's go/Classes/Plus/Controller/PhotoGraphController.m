//
//  PhotoGraphController.m
//  let's go
//
//  Created by qingyun on 16/9/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PhotoGraphController.h"
#import "Masonry.h"

@interface PhotoGraphController ()

@end

@implementation PhotoGraphController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initImgPickerController];
    [self loadDefaultSetting];
}

- (void)initImgPickerController
{
    _imgPickerController = [[UIImagePickerController alloc]init];
    //设置照片的来源 此处设置来源摄像头
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _imgPickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    }else {
        NSLog(@"无法拍摄");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"设备不支持拍摄，请检查" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    _imgPickerController.delegate=self;
    //是否允许编辑 允许用户选择照片的指定区域
    _imgPickerController.allowsEditing = YES;
    
}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UIImageView *imView = [[UIImageView alloc]init];
    [self.view addSubview:imView];
    _imgView = imView;
    imView.frame = self.view.frame;
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnSend];
    [btnSend setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    [btnSend setBackgroundColor:[UIColor clearColor]];
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-30);
        make.centerX.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(50);
    }];
    [btnSend addTarget:self action:@selector(pikerSend) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pikerSend
{
    [self presentViewController:_imgPickerController animated:YES completion:nil];
}

//取消拍摄
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imgPickerController dismissViewControllerAnimated:YES completion:nil];
}
//拍照结束后获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是否是拍照图片模式还是视频拍摄的模式
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        if (_imgPickerController.allowsEditing) {
            //获取编辑的图片,并显示到图像视图中
            _imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else {
            //获取拍照的原始图片
            UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
            _imgView.image = img;
        }
    }
    [_imgPickerController dismissViewControllerAnimated:YES completion:nil];
}
@end
