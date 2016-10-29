//
//  ElTextViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/28.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElTextViewController.h"
#import "ElLoginViewController.h"
#import "ElCommonUtils.h"

@interface ElTextViewController ()

{
    NSTimer *counterDownTimer;
    int freezeCounter;
}

@end

@implementation ElTextViewController

@synthesize targetUser, codeTextField, codeButton, verifyButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)freezeMoreRequest {
    // 一分钟内禁止再次发送
    [self.codeButton setEnabled:NO];
    freezeCounter = 60;
    counterDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownRequestTimer) userInfo:nil repeats:YES];
    [counterDownTimer fire];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证码已发送" message:@"验证码已发送到你请求的手机号码。如果没有收到，可以在一分钟后尝试重新发送。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController dismissViewControllerAnimated:alertController completion:nil];
    }];
    [alertController addAction:cancelAction];
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

- (void)codeButtonAction:(UIButton *)codeButton {
    
    [AVUser requestMobilePhoneVerify:self.targetUser.mobilePhoneNumber withBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [ElCommonUtils displayError:error];
        } else {
            [self freezeMoreRequest];
        }
    }];
    
}


- (IBAction)SureButtonAction:(id)sender {
    
    NSString *smsCode = self.codeTextField.text;
    if (smsCode.length < 6) {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:@"验证码无效。" forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"LeanSMSDemo" code:1024 userInfo:details];
        [ElCommonUtils displayError:error];
        return;
    } [AVUser verifyMobilePhone:smsCode withBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [ElCommonUtils displayError:error];
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"成功" message:@"验证码确认有效" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController dismissViewControllerAnimated:alertController completion:nil];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
            ElLoginViewController *loginView = [[ElLoginViewController alloc] init];
            [self.navigationController pushViewController:loginView animated:YES];
           
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
