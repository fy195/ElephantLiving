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
{
    NSTimer *counterDownTimer;
    int freezeCounter;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@property (weak, nonatomic) IBOutlet UITextField *smscodeTextField;

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
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)RegisterButtonAction:(id)sender {
    if (self.userNameTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"用户名不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }else if (self.passwordTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"密码不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }else if (self.phoneNumberTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"手机号码不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }else if (self.smscodeTextField.text.length < 1) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"验证码不能为空。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }else {
        [AVUser verifyMobilePhone:_smscodeTextField.text withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                 [self creatNewUserInfo];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册成功" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

    
- (IBAction)verifyButtonAction:(id)sender {
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

        [AVUser requestMobilePhoneVerify:phoneNumber withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [self freezeMoreRequest];
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取验证码成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];

                }else {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alertController addAction:cancelAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }];
        }];
    }
}

- (void)creatNewUserInfo {
    
    
    AVUser *userInfo = [AVUser currentUser];
    /**
     *  等级
     */
    [userInfo setObject:@"1" forKey:@"level"];
    /**
     *  粉丝数
     */
    [userInfo setObject:@"0" forKey:@"follower_count"];
    /**
     *  关注数
     */
    [userInfo setObject:@"0" forKey:@"follow_count"];
    /**
     *  收到的礼物
     */
    [userInfo setObject:@"" forKey:@"receive_gift"];
    /**
     *  送出的礼物
     */
    [userInfo setObject:@"" forKey:@"send_gift"];
    /**
     *  魅力值
     */
    [userInfo setObject:@"" forKey:@"charm"];
    /**
     *  用户头像
     */
    [userInfo setObject:@"" forKey:@"headimage"];
    /**
     *  直播封面
     */
    [userInfo setObject:@"" forKey:@"coverimage"];
[userInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    if (succeeded) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"创建对象出错 %@",error);
    }
}];

}





- (void)freezeMoreRequest {
    // 一分钟内禁止再次发送
    [self.verifyButton setEnabled:NO];
    freezeCounter = 60;
    counterDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownRequestTimer) userInfo:nil repeats:YES];
    [counterDownTimer fire];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)countDownRequestTimer {
    static NSString *counterFormat = @"%d秒后获取";
    --freezeCounter;
    if (freezeCounter<= 0) {
        [counterDownTimer invalidate];
        counterDownTimer = nil;
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.verifyButton setEnabled:YES];
    } else {
        [self.verifyButton setTitle:[NSString stringWithFormat:counterFormat, freezeCounter] forState:UIControlStateNormal];
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
