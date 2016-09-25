//
//  AppDelegate.h
//  let's go
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AVIMClient *client;

- (void)loadMainController;
//- (void)loadPlusController;
@end

