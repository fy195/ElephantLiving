//
//  ElMainTabBar.h
//  ElephantLiving
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ElMainTabBar;

@protocol  ElMainTabBarDelegate <NSObject>

@optional

- (void)tabBar:(ElMainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

- (void)tabBarClickMiddleButton:(ElMainTabBar *)tabBar;

@end

@interface ElMainTabBar : UIView

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@property(nonatomic, weak)id <ElMainTabBarDelegate>delegate;



@end
