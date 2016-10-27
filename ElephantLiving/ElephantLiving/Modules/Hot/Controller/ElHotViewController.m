//
//  ElHotViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHotViewController.h"
#import "ElHotCollectionViewCell.h"
#import "ElHotCarouselView.h"
#import "ElWatchViewController.h"

static NSString *const carousel = @"carousel";
@interface ElHotViewController ()
@property (nonatomic, strong) ElHotCarouselView *carouselView;
@end

@implementation ElHotViewController

- (void)viewDidLoad {
    [self createCarouselView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 300, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        ElWatchViewController *view = [[ElWatchViewController alloc] init];
        [self presentViewController:view animated:YES completion:nil];
    }];
}

- (void)createCarouselView {
    self.carouselView = [[ElHotCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _carouselView.imageArray = @[@"1", @"2", @"1", @"2", @"1"];
    [self.view addSubview:_carouselView];
}


@end
