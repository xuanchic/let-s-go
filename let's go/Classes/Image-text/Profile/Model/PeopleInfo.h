//
//  PeopleInfo.h
//  let's go
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PeopleInfo : NSObject<NSCoding>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *sex;

@end
