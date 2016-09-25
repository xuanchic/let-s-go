//
//  ClearCacheTool.h
//  let's go
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClearCacheTool : NSObject
/**
 *
 *  获取path路径文件夹的大小
 *
 *  @param path 要获取大小的文件夹全路径
 *
 *  @return 返回path路径文件夹的大小
 */
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;
/**
 *
 *  清除path路径文件夹的缓存
 *
 *  @param path  要清除缓存的文件夹全路径
 *
 *  @return 是否清除成功
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;

@end
