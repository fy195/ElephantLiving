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
#import "_User.h"

@interface ElForgetPasswordViewController ()

{
    NSTimer *counterDownTimer;
    int freezeCounter;
}


@end

@implementation ElForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.phoneTextNumber setText:[_User currentUser].mobilePhoneNumber];
    
    
    [_phoneTextNumber setValue:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordText setValue:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_codeText setValue:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIImageView *imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.2, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.1)];
    imageViewOne.image = [UIImage imageNamed:@"xingxing1"];
    [self.view addSubview:imageViewOne];
    
    [UIView animateWithDuration:2.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        imageViewOne.frame = CGRectMake(-SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.6, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT * 0.08);
    } completion:^(BOOL finished) {
        [imageViewOne removeFromSuperview];
    }];
    
    
    UIImageView *imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.1, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.1)];
    imageViewTwo.image = [UIImage imageNamed:@"xingxing2"];
    [self.view addSubview:imageViewTwo];
    
    [UIView animateWithDuration:2.0 delay:0.8 options:UIViewAnimationOptionRepeat animations:^{
        imageViewTwo.frame = CGRectMake(-SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.5, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT * 0.08);
    } completion:^(BOOL finished) {
        [imageViewTwo removeFromSuperview];
    }];
    
    
    UIImageView *imageViewThree = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT * 0.3, SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.1)];
    imageViewThree.image = [UIImage imageNamed:@"xingxing3"];
    [self.view addSubview:imageViewThree];
    
    [UIView animateWithDuration:1.8 delay:1.5 options:UIViewAnimationOptionRepeat animations:^{
        imageViewThree.frame = CGRectMake(-SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.7, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT * 0.08);
    } completion:^(BOOL finished) {
        [imageViewThree removeFromSuperview];
    }];

    
    
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
    [self freezeMoreRequest];
    [_User requestMobilePhoneVerify:_phoneTextNumber.text withBlock:^(BOOL succeeded, NSError * _Nullable error) {
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
    
}


- (IBAction)buttonAction:(id)sender {
    
    NSString *newPassword = _passwordText.text;
    NSString *smsCode = _codeText.text;
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
    [_User resetPasswordWithSmsCode:smsCode newPassword:newPassword block:^(BOOL succeeded, NSError *error) {
        if (error) {
            [ElCommonUtils displayError:error];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功" message:@"已经成功重置当前用户的密码！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
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
