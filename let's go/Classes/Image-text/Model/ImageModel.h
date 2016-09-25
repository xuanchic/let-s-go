//
//  ImageModel.h
//  let's go
//
//  Created by qingyun on 16/9/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageModel : NSObject
@property (nonatomic, copy) NSString *strTimeDes;
@property (nonatomic, copy) NSString *strTitle;
/** user	object	微博作者的用户信息字段 详细 */
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) UIImage *imageHeader;
/** pic_urls array图片 */
@property (nonatomic, copy) NSArray *arrPicUrls;
/** imageModel模型初始化方法 */
+ (instancetype)imageModelWithDictionary:(NSDictionary *)dicData withTime:(NSDate *)time;

@end
