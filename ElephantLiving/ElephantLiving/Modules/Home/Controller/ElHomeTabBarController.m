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
#import "ElMainTabBar.h"


@interface ElHomeTabBarController ()
<
ElMainTabBarDelegate
>

@property (nonatomic, weak) ElMainTabBar *mainTabBar;

@property (nonatomic, strong) ElHomePageViewController *homeVC;

@property (nonatomic, strong) ElPersonViewController *personVC;

@end

@implementation ElHomeTabBarController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainTabBar];
    [self SetupAllControllers];

}

- (void)SetupMainTabBar{
    ElMainTabBar *mainTabBar = [[ElMainTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
}

- (void)SetupAllControllers{
    
    NSArray *titles = @[@"", @""];
    NSArray *images = @[@"Home", @"Person"];
    NSArray *selectedImages = @[@"HomeSelected", @"PersonSelected"];
    
    ElHomePageViewController * homeVc = [[ElHomePageViewController alloc] init];
    
    self.homeVC = homeVc;
    
    ElPersonViewController * personVC = [[ElPersonViewController alloc] init];
    self.personVC = personVC;
    

    NSArray *viewControllers = @[homeVc,personVC];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}



#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(ElMainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

- (void)tabBarClickMiddleButton:(ElMainTabBar *)tabBar{
    ElLiveViewController *liveVC = [[ElLiveViewController alloc] init];
    [self presentViewController:liveVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
