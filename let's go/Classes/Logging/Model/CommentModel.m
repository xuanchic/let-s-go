//
//  Comment.m
//  let's go
//
//  Created by qingyun on 16/9/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CommentModel.h"
#import "NSString+string.h"

@implementation CommentModel

+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData {
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    CommentModel *comment = [self new];
    
    
    comment.strTimeDes = dicData[@"times"];
    comment.strText = dicData[@"text"];
    
    return comment;
}

@end
