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
- (void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [self createCarouselView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 300, 100, 100);
    _button.backgroundColor = [UIColor colorWithRed:0.9418 green:1.0 blue:0.7947 alpha:1.0];
    [self.view addSubview:_button];

}

- (void)createCarouselView {
    self.carouselView = [[ElHotCarouselView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _carouselView.imageArray = @[@"1", @"2", @"1", @"2", @"1"];
    [self.view addSubview:_carouselView];
}


@end
