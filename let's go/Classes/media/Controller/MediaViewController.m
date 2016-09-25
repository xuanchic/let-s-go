//
//  mediaViewController.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MediaViewController.h"
#import "WMPlayer.h"
#import "VedioViewCell.h"
#import "VedioModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
//持续时间
//static  CGFloat const MJDuration = 0.25;

@interface MediaViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, strong) UITableView *tableView;


@end

//static NSString *const VedioCellId = @"JGVedioCellId";

@implementation MediaViewController

- (NSMutableArray *)arrData
{
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self getNetData];
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    self.navigationController.navigationBar.translucent = NO;
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 350;
    [self.view addSubview:_tableView];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VedioViewCell class]) bundle:nil] forCellReuseIdentifier:VedioCellId];
    
    __weak typeof(self) weakSelf = self;
    //默认block方法：设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getNetData];
       
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf getNetData];
    }];
   }

#pragma mark - <UITableViewDataSouse> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VedioViewCell *cell = [VedioViewCell cellWithTableView:tableView];
    VedioModel *model = self.arrData[indexPath.row];
    cell.model = model;

    __weak typeof(self) weakSelf = self;
    [cell setButtonBlock:^(UIButton *send) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已提交，请等待审核" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:action];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - 加载数据 -
- (void)getNetData
{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"newlist";
    params[@"c"] = @"data";
    params[@"type"] = @(41);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"list"];
        
        for (NSDictionary *dict in array) {
            VedioModel *model = [[VedioModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接失败，请重新尝试！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}

@end
