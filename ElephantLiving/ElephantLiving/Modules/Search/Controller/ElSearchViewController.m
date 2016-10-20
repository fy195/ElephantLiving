//
//  ElSearchViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElSearchViewController.h"

@implementation ElSearchViewController
- (void)viewWillAppear:(BOOL)animated {


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    topView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:topView];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"取消" forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(0, 0, 100, 30);
    [returnButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:returnButton];
    
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    
    
}

@end
