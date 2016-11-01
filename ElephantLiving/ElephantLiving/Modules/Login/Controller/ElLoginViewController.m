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
#import <AVOSCloud/AVOSCloud.h>


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

- (IBAction)loginButtonAction:(id)sender {
    NSString *phoneNumber =_phoneNumberTextField.text;
    NSString *password = _passwordTextField.text;
    
    if (phoneNumber && password) {
        [AVUser logInWithMobilePhoneNumberInBackground:phoneNumber password:password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
                [self getUserInfo:user];
                NSLog(@"%@",user.objectId);
            }
        }];
    }
}



- (void)getUserInfo:(id)user {
//    AVQuery *query  = [AVQuery queryWithClassName:@"UserInfo"];
//    [query whereKey:@"owner" equalTo:user];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@",error);
//        } else {
//            NSLog(@"%@",objects);
//        }
//    }];
    user = [AVUser currentUser];

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
