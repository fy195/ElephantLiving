//
//  ElLoginViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLoginViewController.h"
#import "ElRegisterViewController.h"
#import "ElForgetPasswordViewController.h"


@interface ElLoginViewController ()

@end

@implementation ElLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)RegisterButton:(id)sender {
    ElRegisterViewController * registerView = [[ElRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}
- (IBAction)ReturnButtonAction:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ForgetPasswordButtonAction:(id)sender {
    ElForgetPasswordViewController *forgetPasswordView = [[ElForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordView animated:YES];
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
