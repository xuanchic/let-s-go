//
//  HeaderSeting.h
//  诉说
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//


#ifndef HeaderSeting_h
#define HeaderSeting_h



#endif /* HeaderSeting_h */

/** QLScreenSize */
#define QLScreenSize [[UIScreen mainScreen] bounds].size
#define QLScreenWidth QLScreenSize.width
#define QLScreenHeight QLScreenSize.height

/** Color Related */
#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))