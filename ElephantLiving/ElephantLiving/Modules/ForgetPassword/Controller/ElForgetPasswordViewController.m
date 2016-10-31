//
//  ElForgetPasswordViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElForgetPasswordViewController.h"
#import "ElCommonUtils.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ElForgetPasswordViewController ()

{
    NSTimer *counterDownTimer;
    int freezeCounter;
}


@end

@implementation ElForgetPasswordViewController

@synthesize phoneTextNumber, passwordText, codeText, codeButton, button;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.phoneTextNumber setText:[AVUser currentUser].mobilePhoneNumber];
    
}
- (IBAction)ReturnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)freezeMoreRequest {
    // 一分钟内禁止再次发送
    [self.codeButton setEnabled:NO];
    freezeCounter = 60;
    counterDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownRequestTimer) userInfo:nil repeats:YES];
    [counterDownTimer fire];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)countDownRequestTimer {
    static NSString *counterFormat = @"%d 秒后再获取";
    --freezeCounter;
    if (freezeCounter<= 0) {
        [counterDownTimer invalidate];
        counterDownTimer = nil;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeButton setEnabled:YES];
    } else {
        [self.codeButton setTitle:[NSString stringWithFormat:counterFormat, freezeCounter] forState:UIControlStateNormal];
    }
}
- (IBAction)codeButton:(id)sender {
    
    [AVUser requestPasswordResetWithPhoneNumber:[AVUser currentUser].mobilePhoneNumber block:^(BOOL succeeded, NSError *error) {
        if (error) {
            [ElCommonUtils displayError:error];
        } else {
            [self freezeMoreRequest];
        }
        ;
    }];
    
}


- (IBAction)buttonAction:(id)sender {
    
    NSString *newPassword = self.passwordText.text;
    NSString *smsCode = self.codeText.text;
    if (newPassword.length < 6) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"密码长度必须在 6 位（含）以上。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }
    if (smsCode.length < 6) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"验证码无效。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    }
    [AVUser resetPasswordWithSmsCode:smsCode newPassword:newPassword block:^(BOOL succeeded, NSError *error) {
        if (error) {
            [ElCommonUtils displayError:error];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功" message:@"已经成功重置当前用户的密码！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
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
