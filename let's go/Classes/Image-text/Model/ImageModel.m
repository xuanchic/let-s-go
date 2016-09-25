//
//  ImageModel.m
//  let's go
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ImageModel.h"
#import "NSString+string.h"

@implementation ImageModel

+ (instancetype)imageModelWithDictionary:(NSDictionary *)dicData withTime:(NSDate *)time
{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil ;
    ImageModel *image = [self new];
    if (!dicData[@"nicheng"]) {
        image.userName = dicData[@"myname"];
    }else {
        image.userName = dicData[@"nicheng"];
    }
    
    image.imageHeader = [UIImage imageWithData:dicData[@"icon"]];
    NSArray *imgArr = dicData[@"pics"];
    NSMutableArray *arrpic = [NSMutableArray arrayWithCapacity:imgArr.count];
    for (NSData *dat in imgArr) {
        UIImage *img = [UIImage imageWithData:dat];
        [arrpic addObject:img];
    }
    image.arrPicUrls = [arrpic copy];
    image.strTimeDes = [NSString descriptionWithString:time];
    image.strTitle = dicData[@"title"];
    

    return image;
}

@end
