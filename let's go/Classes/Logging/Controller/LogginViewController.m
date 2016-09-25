//
//  LogginViewController.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LogginViewController.h"
#import "LogRegistController.h"
#import "StatusCell.h"
#import "TextfildController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "StatusModel.h"
#import "MJRefresh.h"
@interface LogginViewController ()
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSMutableArray *arrUser;
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) StatusCell *cell;

@end

@implementation LogginViewController
- (NSMutableArray *)arrData{
    if (!_arrData) {
        _arrData = [[NSMutableArray alloc]init];
    }
    return _arrData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self theRefresh];
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    // 自动设置当前控制器中的ScrollView的内边距(UIEdgeInsets)
//    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.sectionFooterHeight = 30;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    [self loadData];
}

- (void)loadData
{
    AVQuery *query = [AVQuery queryWithClassName:@"peopleInfo"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:objects.count];
            for (NSDictionary *dic in objects) {
                AVObject *OBJECT = (AVObject *)dic;
                StatusModel *model = [StatusModel statusModelWithDictionary:dic WithCareatAt:OBJECT.createdAt];
                if (model.strTitle) {
                    [arrM addObject:model];
                }
                self.arrData = [arrM copy];
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)theRefresh
{
    __weak typeof(self) weakSelf = self;
    //默认block方法：设置上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    StatusModel *model = self.arrData[indexPath.section];
    cell.status = model;
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
    // 取消IndexPath位置cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)tapAction
{
    LogRegistController *vcReg = [[LogRegistController alloc] init];
    [self.navigationController pushViewController:vcReg animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 10;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10; //这里是我的headerView和footerView的高度
    if (self.tableView.contentOffset.y <=sectionHeaderHeight && self.tableView.contentOffset.y>=0) {
        self.tableView.contentInset = UIEdgeInsetsMake(-self.tableView.contentOffset.y, 0, 0, 0);
    } else if (self.tableView.contentOffset.y>=sectionHeaderHeight) {
        self.tableView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
