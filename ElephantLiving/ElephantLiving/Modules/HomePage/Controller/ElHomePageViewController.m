//
//  ElHomePageViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHomePageViewController.h"
#import "ElTopView.h"
#import "ElListViewController.h"
#import "ElHotViewController.h"
#import "ElNewViewController.h"
#import "ElSearchViewController.h"
#import "ElWatchViewController.h"



@interface ElHomePageViewController ()
<
UIScrollViewDelegate,
ElHotViewControllerDelegate
>
@property (nonatomic, strong) ElTopView *topView;

@property(nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ElListViewController *listVC;

@property (nonatomic, strong) ElHotViewController *hotVC;

@property (nonatomic, strong) ElNewViewController *newestVC;

@end



@implementation ElHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self creatTopView];
    [self creatScrollView];
}

- (void)creatTopView {
    
    self.topView = [[ElTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    _topView.backgroundColor = [UIColor colorWithRed:1.0 green:0.503 blue:0.0028 alpha:1.0];
    
    [_topView.newestButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.scrollView setContentOffset:CGPointMake(0, 1) animated:YES];
    }];
    [_topView.hotButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 1) animated:YES];
    }];
    [_topView.listButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * 2, 1) animated:YES];
    }];
    
    [self.view addSubview:_topView];
    
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(SCREEN_WIDTH / 4 * 3 + 60,30,30, 30);
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [_topView addSubview:searchButton];
    

    [searchButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
    
        ElSearchViewController *searchView = [[ElSearchViewController alloc] init];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:searchView animated:YES];
        
    }];
    
}



- (void)creatScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_topView.height + _topView.y, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.height)];
    [self.view addSubview:_scrollView];

    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    self.listVC = [[ElListViewController alloc] init];
    _listVC.view.frame = CGRectMake(SCREEN_WIDTH * 2,0, _scrollView.width, SCREEN_HEIGHT);
    _listVC.view.backgroundColor = [UIColor clearColor];
    [_scrollView addSubview:_listVC.view];
                         
    self.newestVC = [[ElNewViewController alloc] init];
    _newestVC.view.frame = _listVC.view.frame;
    _newestVC.view.x = 0;
    _newestVC.view.backgroundColor = [UIColor colorWithRed:0.658 green:0.7359 blue:1.0 alpha:1.0];
    [_scrollView addSubview:_newestVC.view];
    
    self.hotVC = [[ElHotViewController alloc] init];
    _hotVC.view.x = SCREEN_WIDTH;
    _hotVC.delegate = self;
    
    [_scrollView addSubview:_hotVC.view];
    
}

- (void)presentWatchControllerWithLiveRoom:(LiveRoom *)liveRoom {
    ElWatchViewController *watchVC = [[ElWatchViewController alloc] init];
    watchVC.liveRoom = liveRoom;
    [self presentViewController:watchVC animated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / SCREEN_WIDTH;
    if (page == 0) {
        [_topView click:_topView.newestButton];
        return;
    }if (page == 1) {
        [_topView click:_topView.hotButton];
        return;
    }else {
     [_topView click:_topView.listButton];
        return;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        self.topView.underLine.centerX = SCREEN_WIDTH / 2 + (scrollView.contentOffset.x - SCREEN_WIDTH) / 4;
}


@end
