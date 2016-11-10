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
@property (weak, nonatomic) IBOutlet UIButton *sinaButton;
@property (weak, nonatomic) IBOutlet UIButton *WeChatButton;
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WeChatToQQ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sinaToWeChat;

@end

@implementation ElLoginViewController

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
    _WeChatToQQ.constant = SCREEN_HEIGHT * 0.008;
    _sinaToWeChat.constant = SCREEN_HEIGHT * 0.008;
}

- (IBAction)RegisterButton:(id)sender {
    
    ElRegisterViewController * registerView = [[ElRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (IBAction)loginButtonAction:(id)sender {
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
                
                ElHomeTabBarController *homeView = [[ElHomeTabBarController alloc] init];
                [self.navigationController pushViewController:homeView animated:YES];
                
            }];
        }
    } toPlatform:AVOSCloudSNSQQ];
}

- (IBAction)WeChatLogin:(id)sender {
    if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSWeiXin]) {
        // 请到真机测试
        [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
            if (!error) {
                    [_User loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiXin block:^(AVUser *user, NSError *error) {
                        NSString *username = object[@"username"];
                        NSString *avatar = object[@"avatar"];
                        _User *weixinUser = (_User *)user;
                        weixinUser.username = username;
                        weixinUser.headImage = avatar;
                        [weixinUser saveInBackground];
                    }];
//                    "access_token" = "OezXcEiiBSKSxW0eoylIeN_WWsgxroiydYCNnIX5hyDjK3CwA1hc2bvS1oaaaYqwpP7_vb7nhWadkCXGQukQ0hVjCPvWDHjGqSAF0utf2xvXG5coBh2RZViBKxd0POkMDYu0vNLQoBOTfl9yDzzLJQ";
//                    avatar = "http://wx.qlogo.cn/mmopen/3Qx7ibib84ibZMVgJAaEAN7HW8Kyc3s0hLTKcuSlzSJibG8Mbr4g3PsApj8G1u5XxLq9Dnp7XiafxL9h4RSCUIbX39l6lc90Kyzcx/0";
//                    "expires_at" = "2015-07-30 08:38:24 +0000";
//                    id = oazTlwQwmWLyzz7wxnAXDsSZUjcM;
//                    platform = 3;
//                    "raw-user" =     {
//                        city = "";
//                        country = CN;
//                        headimgurl = "http://wx.qlogo.cn/mmopen/3Qx7ibib84ibZMVgJAaEAN7HW8Kyc3s0hLTKcuSlzSJibG8Mbr4g3PsApj8G1u5XxLq9Dnp7XiafxL9h4RSCUIbX39l6lc90Kyzcx/0";
//                        language = "zh_CN";
//                        nickname = "\U674e\U667a\U7ef4";
//                        openid = oazTlwQwmWLyzz7wxnAXDsSZUjcM;
//                        privilege =         (
//                        );
//                        province = Beijing;
//                        sex = 1;
//                        unionid = ox7NLs813rA9sP6QPbadkulxgHn8;
//                    };
//                    username = "\U674e\U667a\U7ef4";
//                }
//                NSLog(@"姓名: %@", [object username]);
//                
            }else {
                NSLog(@"object : %@ error:%@", object, error);
            }

        } toPlatform:AVOSCloudSNSWeiXin];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有安装微信,暂不能登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }

    
    
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
                ElHomeTabBarController *homeView = [[ElHomeTabBarController alloc] init];
                [self.navigationController pushViewController:homeView animated:YES];
            }];
        }
    } toPlatform:AVOSCloudSNSSinaWeibo];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
