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


@interface ElHomeTabBarController ()

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSArray *norImage;

@property (nonatomic, strong) NSArray *seleImage;
@end

@implementation ElHomeTabBarController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadControllers];
    [self creationCusTabBar];
    
}
- (void)loadControllers {

    ElHomePageViewController *homeVC = [[ElHomePageViewController alloc] init];
    UINavigationController *homeNaV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    ElLiveViewController *liveVC = [[ElLiveViewController alloc] init];
    
    ElPersonViewController *personVC = [[ElPersonViewController alloc] init];
    
    self.viewControllers = @[homeNaV,liveVC,personVC];
    
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.alpha = 0.7;
    [self.tabBar addSubview:_bottomView];
}

- (void)creationCusTabBar {

    self.norImage = @[@"1",@"1",@"1"];
    self.seleImage = @[@"2",@"2",@"2"];
    
    CGFloat width = SCREEN_WIDTH / 4;
    
    
    for (NSInteger i = 0; i< 3; i++)
    {
        
        //按钮：
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:[_norImage objectAtIndex:i]]  forState:UIControlStateNormal];
        if (i == 0) {
            btn.selected = YES;
        }
        [btn setImage:[UIImage imageNamed:[_seleImage objectAtIndex:i]] forState:UIControlStateSelected];

        btn.tag = i+1000;
        
        [btn addTarget:self action:@selector(TapBnt:) forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(_bottomView.height / 2, _bottomView.height / 2);
        if (i == 1) {
            btn.center = _bottomView.center;
            btn.size = CGSizeMake(_bottomView.height / 3 * 2, _bottomView.height / 3 * 2);
        }
        if (i == 0) {
            btn.centerX = width;
        }
        if (i == 2) {
            btn.centerX = width * 3;
        }
        
        btn.centerY = _bottomView.centerY;
        
        [self.view addSubview:btn];
        
    }
}
- (void)TapBnt: (UIButton *)sender
{
    for (int i = 0; i < 3; i++)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:i+1000];
        btn.selected = NO;
    }
    sender.selected = YES;
    //切换控制器：
    self.selectedIndex = sender.tag - 1000;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
