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
#import "AVOSCloud/AVOSCloud.h"
#import "_User.h"
#import <LeanCloudSocial/LeanCloudSocial-umbrella.h>
#import "ElHomeTabBarController.h"

@interface ElLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *sinaButton;
@property (weak, nonatomic) IBOutlet UIButton *QQButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIImageView *roadImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roadImageOriginY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roadImageOriginX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerButtonOriginY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerButtonOriginX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QQbuttonToRoad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roadImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roadImageHeight;

@end

@implementation ElLoginViewController
{
    NSTimer *counterDownTimer;
    int freezeCounter;
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_phoneNumberTextField setValue:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneNumberTextField becomeFirstResponder];
    [_passwordTextField setValue:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTextField becomeFirstResponder];
    _roadImageOriginY.constant = SCREEN_HEIGHT * 0.59;
    _roadImageOriginX.constant = SCREEN_WIDTH * 0.10;
    _registerButtonOriginY.constant = SCREEN_HEIGHT * 0.57;
    _registerButtonOriginX.constant = SCREEN_WIDTH * 0.09;
    _roadImageWidth.constant = SCREEN_WIDTH * 0.41;
    _roadImageHeight.constant = SCREEN_HEIGHT * 0.20;
    _QQbuttonToRoad.constant = - SCREEN_HEIGHT * 0.18;
}

- (IBAction)RegisterButton:(id)sender {
    
    ElRegisterViewController * registerView = [[ElRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (IBAction)loginButtonAction:(id)sender {
    [self freezeMoreRequest];
    NSString *phoneNumber =_phoneNumberTextField.text;
    NSString *password = _passwordTextField.text;
    
    if (phoneNumber && password) {
        [_User logInWithMobilePhoneNumberInBackground:phoneNumber password:password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            } else {
                [self getUserInfo:user];
                ElHomeTabBarController *homeView = [[ElHomeTabBarController alloc] init];
                [self.navigationController pushViewController:homeView animated:YES];
            }
        }];
    }
}

- (void)freezeMoreRequest {
    // 一分钟内禁止再次发送
    [self.loginButton setEnabled:NO];
    freezeCounter = 60;
    counterDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownRequestTimer) userInfo:nil repeats:YES];
    [counterDownTimer fire];
}

- (void)countDownRequestTimer {
    --freezeCounter;
    if (freezeCounter<= 0) {
        [counterDownTimer invalidate];
        counterDownTimer = nil;
        [self.loginButton setEnabled:YES];
    }
}

- (void)getUserInfo:(id)user {
    user = [_User currentUser];

}

- (IBAction)ForgetPasswordButtonAction:(id)sender {
    ElForgetPasswordViewController *forgetPasswordView = [[ElForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordView animated:YES];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_passwordTextField resignFirstResponder];
    [_phoneNumberTextField resignFirstResponder];
}



- (IBAction)QQLogin:(id)sender {
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"failed to get authentication from weibo. error: %@", error.description);
        } else {
            [_User loginWithAuthData:object platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                NSString *username = object[@"username"];
                NSString *avatar = object[@"avatar"];
                _User *qqUser = (_User *)user;
                qqUser.username = username;
                qqUser.headImage = avatar;
                [qqUser saveInBackground];
            }];
        }
    } toPlatform:AVOSCloudSNSQQ];
}

- (IBAction)weiboLogin:(id)sender {
    
    NSLog(@"微博");
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"failed to get authentication from weibo. error: %@", error.description);
        } else {
            [_User loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                NSString *username = object[@"username"];
                NSString *avatar = object[@"avatar"];
                _User *qqUser = (_User *)user;
                qqUser.username = username;
                qqUser.headImage = avatar;
                [qqUser saveInBackground];
            }];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
