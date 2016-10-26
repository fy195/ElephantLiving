//
//  ElLiveViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ElStartLiving.h"

@interface ElLiveViewController ()

@end

@implementation ElLiveViewController

- (void)viewWillAppear:(BOOL)animated {

    ElStartLiving *view = [[ElStartLiving alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    
}




@end
