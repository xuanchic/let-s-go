//
//  TabBar.m
//  let's go
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TabBar.h"
#import "AppDelegate.h"
@implementation TabBar

{
    __weak UIButton *_btnPlus;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
/**加载默认设置和UI*/
- (void)loadDefaultSetting
{
    UIButton *btnPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btnPlus setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btnPlus setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [btnPlus addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchDown];
    //btnPlus.frame = CGRectMake(0, 0, 40, 40);
    [btnPlus sizeToFit];
    [self addSubview:btnPlus];
    _btnPlus = btnPlus;
  
}

- (void)tapAction:(UIButton *)button
{
    //NSLog(@"%s",__func__);
    if ([self.delegates respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegates tabBarDidClickPlusButton:self];
    }
   
}
// 布局子视图就会调用此方法, 系统调用, 会调用多次
- (void)layoutSubviews {
    [super layoutSubviews];
    // 取出当前所有的UITabBarButton
    NSArray *arrViews = self.subviews;
    //NSLog(@"%@", arrViews);
    // 遍历所有的子视图, 过滤出所有的UITabBarButton
    NSUInteger count = arrViews.count;
    NSMutableArray *arrTabBarButtons = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        UIView *view = arrViews[index];
        Class clsView = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:clsView]) {
            [arrTabBarButtons addObject:view];
        }
    }
    // 布局所有的UITabBarButton
    NSUInteger itemCount = arrTabBarButtons.count;
    CGFloat itemWidth = self.frame.size.width / (itemCount + 1);
    CGFloat itemHeight = self.frame.size.height;
    for (NSUInteger index = 0; index < itemCount; index ++) {
        CGFloat itemX = 0;
        if (index >= itemCount / 2) {
            itemX = (index + 1) * itemWidth;
        } else {
            itemX = index * itemWidth;
        }
        // view实际上就是一个UITabBarButton类型的view
        UIView *view = arrTabBarButtons[index];
        view.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
    }
    
    // 布局btnPlus
    _btnPlus.frame = CGRectMake(itemCount/2 * itemWidth, 0, itemWidth, itemHeight);
    _btnPlus.layer.cornerRadius = itemWidth/2;
    _btnPlus.layer.masksToBounds = YES;
}

@end
