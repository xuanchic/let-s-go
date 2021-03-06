//
//  FooterView.m
//
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FooterView.h"
#import "StatusModel.h"

@implementation FooterView

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    static NSString *strId = @"FooterView";
    FooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strId];
    if (footer == nil) {
        footer = [[[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil] firstObject];
        [footer setValue:strId forKey:@"reuseIdentifier"];
    }
    
    return footer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 当从xib启动时候, 如果重写方法中outlet还没有被赋值
    // 一定要想到awakeFromNib
}

- (void)setStatus:(StatusModel *)status {
    _status = status;
    NSLog(@"");
    
    // 如果这个数字大于0 , 显示这个数字, 否则显示原有的转发, 赞, 评论
    [self loadTitle:@"转发" count:status.repostsCount forButton:self.btnRetweet];
    [self loadTitle:@"评论" count:status.commentsCount forButton:self.btnComment];
    [self loadTitle:@"点赞" count:status.attitudesCount forButton:self.btnPraise];
}


- (void)loadTitle:(NSString *)title count:(NSInteger)count forButton:(UIButton *)button {
    if (count == 0) {
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:[NSString stringWithFormat:@"%ld", (long)count] forState:UIControlStateNormal];
    }
}



//- (void)didMoveToWindow {
//    [self sendSubviewToBack:_viewBg];
//    
//    //NSTimer *timer;
//    //// 设置计时器触发的日期在很久很久很久之后(你的应用不可能活到那个时候的)
//    //[timer setFireDate:[NSDate distantFuture]];
//    //// 设置现在就开始计时
//    //[timer setFireDate:[NSDate date]];
//}

@end
