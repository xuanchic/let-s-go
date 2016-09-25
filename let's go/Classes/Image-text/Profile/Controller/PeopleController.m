//
//  PeopleController.m
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PeopleController.h"
#import "FindpassWord.h"
#import "AppDelegate.h"
#import "editView.h"
#import "Masonry.h"
#import "TZImagePickerController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PeopleInfo.h"

@interface PeopleController ()<TZImagePickerControllerDelegate>
{
    BOOL _isAppeared;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;
@property (nonatomic, weak) editView *editView;


@end

@implementation PeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    [self loadDefaultSetting];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_isAppeared) {
        [self updateUI];
    }
}
- (void)updateUI{
    //在页面即将加载时赋值
    self.lblNumber.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (self.lblNumber.text != nil) {
            AVQuery *query = [AVQuery queryWithClassName:@"people"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

            for (NSDictionary *dic in objects) {
                self.lblName.text = dic[@"nicheng"];
                self.lblSex.text = dic[@"sex"];
                UIImage *image =  [UIImage imageWithData:dic[@"icon"]];
                if (self.imageHeader.image != image) {
                    self.imageHeader.image = image;
                }
            }
        }];
        
    }else {
        self.lblName.text = nil;
        self.lblSex.text = nil;
        self.imageHeader.image = nil;
    }
    _isAppeared = YES;
}

/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didOK)];
    self.navigationItem.rightBarButtonItem = btnRight;
    
    [self.imageHeader setUserInteractionEnabled:YES];
    if (self.imageHeader.image  == nil) {
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressClose)];
        [tapGes setNumberOfTouchesRequired:1];
        [tapGes setNumberOfTapsRequired:1];
        [self.imageHeader addGestureRecognizer:tapGes];
    }
    
    //加载图片
    //    [_imageHeader sd_setImageWithURL:[[AVUser currentUser]objectForKey:@"icon"]];
    
    //弹出框
    editView *edit = [editView addItems];
    [self.view addSubview:edit];
    self.editView = edit;
    edit.alpha = 0;
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(80);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    __weak typeof(self) vc = self;
    [edit setEditOkBlock:^(NSString *text, NSInteger tag) {
        switch (tag) {
            case 100:
                vc.lblName.text = text;
                break;
            case 101:
                vc.lblSex.text = text;
                break;
            default:
                break;
        }
    }];
}

- (void)pressClose
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self saveLocation:nil];
    }];
    UIAlertAction *actionCanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:actionOK];
    [alert addAction:actionCanle];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)headerImagebtn:(id)sender
{
    TZImagePickerController *imagePickVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //让禁止调用视频
    imagePickVc.sortAscendingByModificationDate = NO;
    [imagePickVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //获取照片后赋值给头像
        dispatch_async(dispatch_get_main_queue(), ^{
         self.imageHeader.image = photos[0];
           [self saveLocation:photos[0]];
        });
    }];
    
   [self presentViewController:imagePickVc animated:YES completion:nil];
}

- (IBAction)nameBtn:(UIButton *)sender {
    self.editView.alpha = 1;
    self.editView.btnTag = sender.tag;
}

- (IBAction)sexBtn:(UIButton *)sender {
        self.editView.alpha = 1;
        self.editView.btnTag = sender.tag;
}

- (IBAction)RepassWord:(id)sender {
    
    FindpassWord *find = [[FindpassWord alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}

- (void)didOK
{
    //将值写入服务器
    AVObject *peopleInfo = [AVObject objectWithClassName:@"people"];
    NSData *data = UIImagePNGRepresentation(self.imageHeader.image);
    [peopleInfo setObject:self.lblNumber.text forKey:@"myname"];
    [peopleInfo setObject:data forKey:@"icon"];
    [peopleInfo setObject:self.lblName.text forKey:@"nicheng"];
    [peopleInfo setObject:self.lblSex.text forKey:@"sex"];
    
    [peopleInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"上传成功");
            [self saveLocation:self.imageHeader.image];
            //获取存储成功后云端返回的objectId
            NSString *strid = peopleInfo.objectId;
            self.strId = strid;
            AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [dele loadMainController];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查网络" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            
            [alert addAction:actionOK];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

//保存数据到本地文件
- (void)saveLocation:(UIImage *)image{
    
    PeopleInfo *info = [[PeopleInfo alloc] init];
//    info.image = nil;
    info.image = image;
    info.name = self.lblName.text;
    info.sex = self.lblSex.text;
    
    //获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"people.plist"];
//    NSLog(@"-------%@-------",path);
    //3.将自定义的对象保存到文件中
    [NSKeyedArchiver archiveRootObject:info toFile:path];
//    [self updateUI];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.editView setAlpha:0];
}
@end
