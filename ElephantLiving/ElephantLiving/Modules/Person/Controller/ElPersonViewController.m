//
//  ElPersonViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElPersonViewController.h"
#import "ElPersonHeaderView.h"

@implementation ElPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ElPersonHeaderView *view = [[ElPersonHeaderView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT * 0.5)];
    [self.view addSubview:view];
    
    
}

@end
