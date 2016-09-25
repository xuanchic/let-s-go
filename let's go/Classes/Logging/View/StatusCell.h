//
//  StatusCell.h
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusModel;


@interface StatusCell : UITableViewCell

@property (nonatomic, copy) void(^ButtonBlock)(UIButton *);

@property (nonatomic, strong) StatusModel *status;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
