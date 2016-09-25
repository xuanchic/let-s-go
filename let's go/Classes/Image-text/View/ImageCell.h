//
//  ImageCell.h
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageModel;
@interface ImageCell : UITableViewCell
@property (nonatomic, copy) void(^ButtonBlock)(UIButton *);
@property (nonatomic, strong) ImageModel *imageModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
