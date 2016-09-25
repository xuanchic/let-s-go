//
//  Comment.h
//  let's go
//
//  Created by qingyun on 16/9/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

/** created_at: 创建时间 */
@property (nonatomic, copy) NSString *strTimeDes;

/** text: 评论文本 */
@property (nonatomic, copy) NSString *strText;

/** 评论模型的初始化方法 */
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData;

@end
