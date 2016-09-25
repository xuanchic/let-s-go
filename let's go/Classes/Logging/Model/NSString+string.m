//
//  NSString+string.m
//  let's go
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSString+string.h"

@implementation NSString (string)

+ (instancetype)descriptionWithString:(NSDate *)strDate
{
    //1.获取当前的时间
    NSDate *dateNow = [NSDate date];
    
    //获取发布时间
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
//    NSDate *datePunlish = [formatter dateFromString:strDate];
    // 3, 计算两个时间的时间差
    NSTimeInterval interval =[dateNow timeIntervalSinceDate:strDate];
    // 4, 根据时间差的结果进行分类, 刚刚(1分钟内), 几分钟前, 几个小时之前, 几天前.....
//    NSLog(@"---------%f", interval);
    NSString *strDateDes = nil;
    if (interval <= 60) { // 一分钟内
        strDateDes = @"刚刚";
    } else if (interval <= 60 * 60) { // 一个小时内
        strDateDes = [NSString stringWithFormat:@"%ld分钟前", (long)interval / 60 + 1];
    } else if (interval <= 60 * 60 * 24) { // 几个小时之前
        strDateDes = [NSString stringWithFormat:@"%ld小时前", (long)interval / (60 * 60) + 1];
    } else { // 几天前
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        strDateDes = [formatter stringFromDate:strDate];
    }
    
    return strDateDes;
}
@end
