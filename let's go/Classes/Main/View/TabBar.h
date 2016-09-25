//
//  TabBar.h
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBar;

@protocol TabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(TabBar *)tabbar;

@end

@interface TabBar : UITabBar

@property (nonatomic, weak) id<TabBarDelegate> delegates;
@end
