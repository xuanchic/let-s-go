//
//  StatusModel.h
//  let's go
//
//  Created by qingyun on 16/9/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StatusModel : NSObject

/** screen_name	string	用户昵称, NickName */
@property (nonatomic, copy) NSString *strScreenName;
/** avatar_hd	string	用户头像地址（高清），高清头像原图 */
@property (nonatomic, strong) UIImage *imgHeader;

/** created_at	string	微博创建时间 */
@property (nonatomic, copy) NSString *strTimeDes;
/** idstr	string	字符串型的title */
@property (nonatomic, copy) NSString *strTitle;
/** text	string	信息内容 */
@property (nonatomic, copy) NSString *strText;

/** reposts_count	int	转发数 */
@property (nonatomic, assign) NSInteger repostsCount;
/** comments_count	int	评论数 */
@property (nonatomic, assign) NSInteger commentsCount;
/** attitudes_count	int	表态数 */
@property (nonatomic, assign) NSInteger attitudesCount;

/** QYStatusModel模型初始化方法 */
+ (instancetype)statusModelWithDictionary:(NSDictionary *)dicData WithCareatAt:(NSDate *)creatAt;

@end
