//
//  QYFooterView.h
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusModel;

@interface FooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UIView *viewBg;
@property (nonatomic, weak) IBOutlet UIButton *btnComment;
@property (nonatomic, weak) IBOutlet UIButton *btnPraise;
@property (nonatomic, weak) IBOutlet UIButton *btnRetweet;


@property (nonatomic, strong) StatusModel *status;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end
