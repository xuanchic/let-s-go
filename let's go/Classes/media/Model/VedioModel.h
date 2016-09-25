//
//  VedioModel.h
//  let's go
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VedioModel : NSObject

/** 视频连接  */
@property(nonatomic, copy) NSString *videouri;
/** 提供者图像  */
@property(nonatomic, copy) NSString *profile_image;
/** 视频说明  */
@property(nonatomic, copy) NSString *text;
/** 提供者名称  */
@property(nonatomic, copy) NSString *name;
/** 播放时长  */
@property(nonatomic, copy) NSString *videotime;
/** 图片  */
@property(nonatomic, copy) NSString *cdn_img;
/** 播放次数  */
@property(nonatomic, assign) int playcount;
/** 时间  */
@property(nonatomic, copy) NSString *create_time;

@end
