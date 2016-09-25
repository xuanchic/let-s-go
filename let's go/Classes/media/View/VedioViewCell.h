//
//  VedioViewCell.h
//  let's go
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VedioModel;
@interface VedioViewCell : UITableViewCell
@property (nonatomic, copy) void(^ButtonBlock)(UIButton *);
@property (nonatomic, copy) VedioModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
