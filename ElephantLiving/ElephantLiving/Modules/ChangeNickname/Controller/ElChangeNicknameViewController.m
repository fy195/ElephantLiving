//
//  ElChangeNicknameViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/11/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElChangeNicknameViewController.h"
#import "_User.h"

@interface ElChangeNicknameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ElChangeNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)returnButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)sureButton:(id)sender {
    _User *user = [_User currentUser];
    user.username = _textField.text;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"昵称修改成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                }];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];            
        }else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end