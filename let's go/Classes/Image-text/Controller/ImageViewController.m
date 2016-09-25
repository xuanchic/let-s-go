//
//  imageViewController.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ImageModel.h"
#import "MJRefresh.h"

@interface ImageViewController ()

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSMutableArray *arrmodel;

@end

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 40;
    self.tableView.sectionFooterHeight = 30;
//    [self loadDefaultSetting];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];

}

///**加载默认设置和UI*/
//- (void)loadDefaultSetting
//{
//    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(theRefresh)];
//    self.navigationItem.rightBarButtonItem = btnRight;
//}

- (void)loadData
{
    self.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    AVQuery *query = [AVQuery queryWithClassName:@"imgText"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.arrmodel = [NSMutableArray arrayWithCapacity:objects.count];
            for (NSDictionary *dic in objects) {
                AVObject *OBJECT = (AVObject *)dic;
                ImageModel *model = [ImageModel imageModelWithDictionary:dic withTime:OBJECT.createdAt];
                [self.arrmodel addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arrmodel.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [ImageCell cellWithTableView:tableView];
    ImageModel *model = self.arrmodel[indexPath.section];
    cell.imageModel = model;
    __weak typeof(self) weakSelf = self;
    [cell setButtonBlock:^(UIButton *send) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已提交，请等待审核" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
