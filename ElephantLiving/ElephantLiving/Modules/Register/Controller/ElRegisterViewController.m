//
//  ElRegisterViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElRegisterViewController.h"
#import "ElTextViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ElCommonUtils.h"


@interface ElRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ElRegisterViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [AVAnalytics beginLogPageView:@"SignUpView"];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [AVAnalytics endLogPageView:@"SignUpView"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)ReturnButton:(id)sender {
//    ElLoginViewController *loginView = [[ElLoginViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)RegisterButtonAction:(id)sender {
    
    
    if (self.userNameTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"用户名不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }
    if (self.passwordTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"密码不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }
    if (self.phoneNumberTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"手机号码不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }

    
    NSString *userName = _userNameTextField.text;
    NSString *phoneNumber = _phoneNumberTextField.text;
    NSString *password = _passwordTextField.text;
    
    if (userName && password && phoneNumber) {
        AVUser *user = [AVUser user];
        user.username = userName;
        user.mobilePhoneNumber = phoneNumber;
        user.password = password;
        NSError *error = nil;
        [user signUp:&error];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                ElTextViewController *textView = [[ElTextViewController alloc] init];
                [self.navigationController pushViewController:textView animated:YES];
                
            } else {
            
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发生错误" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];

            
            }
            
        }];
    }
    
    
    
    
    
    
    
    
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
