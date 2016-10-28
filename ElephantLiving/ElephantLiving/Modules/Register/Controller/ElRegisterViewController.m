//
//  ElRegisterViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElRegisterViewController.h"
#import "ElTextViewController.h"

@interface ElRegisterViewController ()

@end

@implementation ElRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ReturnButton:(id)sender {
//    ElLoginViewController *loginView = [[ElLoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)RegisterButtonAction:(id)sender {
    ElTextViewController *textView = [[ElTextViewController alloc] init];
    [self.navigationController pushViewController:textView animated:YES];
    
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
