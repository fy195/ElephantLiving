//
//  ElHomeTabBarController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHomeTabBarController.h"
#import "ElHomePageViewController.h"
#import "ElLiveViewController.h"
#import "ElPersonViewController.h"
#import "ElTabBar.h"

@interface ElHomeTabBarController ()
<ElTabBarDelegate>

@property (nonatomic, strong) ElTabBar *bottomView;

@property (nonatomic, assign) BOOL isSelected;


@end

@implementation ElHomeTabBarController


- (void)viewWillAppear:(BOOL)animated {
    self.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadControllers];
    
    
    self.bottomView = [[ElTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.alpha = 0.8;
    _bottomView.delegateOfPresent = self;
    [self.tabBar addSubview:self.bottomView];
    

}
- (void)loadControllers {
    ElHomePageViewController *homeVC = [[ElHomePageViewController alloc] init];
    UINavigationController *homeNaV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    ElLiveViewController *liveVC = [[ElLiveViewController alloc] init];
    ElPersonViewController *personVC = [[ElPersonViewController alloc] init];
    self.viewControllers = @[homeNaV,liveVC,personVC];
}

- (void)getButtonTag:(NSInteger)tag {
    self.selectedIndex = tag - 1000;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
