//
//  ElUsViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/11/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElUsViewController.h"

@interface ElUsViewController ()

@end

@implementation ElUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    titleLabel.text = @"关于我们";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor clearColor];
    returnButton.frame = CGRectMake(SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.09, SCREEN_WIDTH * 0.09);
    [returnButton setTitle:@"⇦" forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    returnButton.centerY = titleLabel.centerY;
    [self.view addSubview:returnButton];
    
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
