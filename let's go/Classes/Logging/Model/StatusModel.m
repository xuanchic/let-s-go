//
//  StatusModel.m
//  let's go
//
//  Created by qingyun on 16/9/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "StatusModel.h"
#import "NSString+string.h"

@implementation StatusModel

+ (instancetype)statusModelWithDictionary:(NSDictionary *)dicData WithCareatAt:(NSDate *)creatAt
{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    StatusModel *status = [self new];
    
    status.strTimeDes = [NSString descriptionWithString:creatAt];
    status.strTitle = dicData[@"title"];
    status.strText = dicData[@"text"];
    if (!dicData[@"nicheng"]) {
        status.strScreenName = dicData[@"myname"];
    }else {
        status.strScreenName = dicData[@"nicheng"];
    }
    status.imgHeader = [UIImage imageWithData: dicData[@"icon"]];
    
    
//    status.commentsCount = [dicData[@"comments_count"]integerValue];
//    status.attitudesCount = [dicData[@"attitudes_count"]integerValue];
//    status.repostsCount = [dicData[@"reposts_count"]integerValue];
    return status;
    
}

@end
