//
//  editView.h
//  let's go
//
//  Created by qingyun on 16/9/10.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editView : UIView

@property (nonatomic, assign) NSInteger btnTag;
@property (nonatomic, copy) void(^editOkBlock)(NSString *strComment, NSInteger tag);

+ (instancetype)addItems;

@end
