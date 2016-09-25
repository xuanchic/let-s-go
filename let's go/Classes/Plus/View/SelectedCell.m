//
//  SelectedCell.m
//  let's go
//
//  Created by qingyun on 16/9/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
    
}

- (void)createUI{
    
    
    self.imageViews = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)]
    ;
    
    //self.iv.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:self.imageViews];
    
    
}

@end
