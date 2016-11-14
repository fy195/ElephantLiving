//
//  ElMainTabBar.m
//  ElephantLiving
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElMainTabBar.h"
#import "ElMainTabBarButton.h"


@interface ElMainTabBar ()

@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;

@property(nonatomic, weak)UIButton *liveButton;

@property(nonatomic, weak)ElMainTabBarButton *selectedButton;


@end


@implementation ElMainTabBar

- (NSMutableArray *)tabbarBtnArray{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0.9952 green:0.9904 blue:1.0 alpha:1.0];
        [self SetupMiddleButton];
    }
    
    return self;
}

- (void)SetupMiddleButton{
    
    UIButton *liveButton = [UIButton new];
    liveButton.adjustsImageWhenHighlighted = NO;
    [liveButton setBackgroundImage:[UIImage imageNamed:@"live"] forState:UIControlStateNormal];
    [liveButton addTarget:self action:@selector(ClickLiveButton) forControlEvents:UIControlEventTouchUpInside];
    liveButton.bounds = CGRectMake(0, 0, liveButton.currentBackgroundImage.size.width, liveButton.currentBackgroundImage.size.height);
    [self addSubview:liveButton];
    _liveButton = liveButton;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.liveButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        ElMainTabBarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        if (nIndex == 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    ElMainTabBarButton *tabBarBtn = [[ElMainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}

- (void)ClickTabBarButton:(ElMainTabBarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickLiveButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickMiddleButton:)]) {
        [self.delegate tabBarClickMiddleButton:self];
    }
}


@end
