//
//  ElSettingViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElSettingViewController.h"
#import "ElLoginViewController.h"
#import "ElAVOSCloud.h"

@interface ElSettingViewController ()

@end

@implementation ElSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9255 green:0.9255 blue:0.9373 alpha:1.0];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor clearColor];
    returnButton.frame = CGRectMake(SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.09, SCREEN_WIDTH * 0.09);
    [returnButton setTitle:@"⇦" forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    returnButton.centerY = titleLabel.centerY;
    [self.view addSubview:returnButton];
    
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];

    
    UIView *livingView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.1, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08)];
    livingView.layer.borderWidth = 1;
    livingView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    livingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:livingView];
    
    UILabel *livingLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, 0, SCREEN_WIDTH, livingView.height)];
    livingLabel.text = @"开播提醒";
    livingLabel.textAlignment = NSTextAlignmentLeft;
    [livingView addSubview:livingLabel];
    
    UISwitch *livingSwitch = [[UISwitch alloc] init];
    livingSwitch.frame = CGRectMake(SCREEN_WIDTH - livingSwitch.width - livingLabel.x, 0, 0, 0);
    livingSwitch.centerY = livingLabel.centerY;
    [livingView addSubview:livingSwitch];
    
    
    UILabel *livingTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, SCREEN_HEIGHT * 0.18, SCREEN_WIDTH, SCREEN_HEIGHT * 0.04)];
    livingTextLabel.text = @"开启后,你关注的主播开播时你会收到通知";
    livingTextLabel.textAlignment = NSTextAlignmentLeft;
    livingTextLabel.textColor = [UIColor lightGrayColor];
    livingTextLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:livingTextLabel];
    
    
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.23, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08)];
    messageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    messageView.layer.borderWidth = 1;
    messageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:messageView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, 0, SCREEN_WIDTH, messageView.height)];
    messageLabel.text = @"公聊消息过滤";
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [messageView addSubview:messageLabel];
    
    UISwitch *messagesSwitch = [[UISwitch alloc] init];
    messagesSwitch.frame = CGRectMake(livingSwitch.x, livingSwitch.height, 0, 0);
    messagesSwitch.centerY = messageLabel.centerY;
    [messageView addSubview:messagesSwitch];
    
    UILabel *messageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, SCREEN_HEIGHT * 0.31, SCREEN_WIDTH, SCREEN_HEIGHT * 0.04)];
    messageTextLabel.text = @"开启后,显示当前主播和你相关的公聊消息";
    messageTextLabel.textAlignment = NSTextAlignmentLeft;
    messageTextLabel.textColor = [UIColor lightGrayColor];
    messageTextLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:messageTextLabel];
    
    
    UIButton *cacheButton= [UIButton buttonWithType:UIButtonTypeCustom];
    cacheButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.36, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08);
    cacheButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cacheButton.layer.borderWidth = 1;
    cacheButton.backgroundColor = [UIColor whiteColor];
    
    UILabel *cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, 0, SCREEN_WIDTH, cacheButton.height)];
    cacheLabel.text = @"清除缓存";
    cacheLabel.textAlignment = NSTextAlignmentLeft;
    [cacheButton addSubview:cacheLabel];
    
    [self.view addSubview:cacheButton];
    
   
    
    UIButton *aboutUs = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUs.frame = CGRectMake(0, SCREEN_HEIGHT * 0.49, SCREEN_WIDTH, SCREEN_HEIGHT * 0.08);
    aboutUs.layer.borderWidth = 1;
    aboutUs.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aboutUs.backgroundColor = [UIColor whiteColor];
    
    UILabel *aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, 0, SCREEN_WIDTH, aboutUs.height)];
    aboutUsLabel.text = @"关于我们";
    aboutUsLabel.textAlignment = NSTextAlignmentLeft;
    [aboutUs addSubview:aboutUsLabel];
    
    [self.view addSubview:aboutUs];
    
    
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_HEIGHT * 0.9, SCREEN_WIDTH * 0.9, SCREEN_HEIGHT * 0.08);

    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor colorWithRed:1 green:0.5 blue:0 alpha:1] forState:UIControlStateNormal];
    exitButton.layer.cornerRadius = SCREEN_HEIGHT * 0.08 / 2;
    [exitButton.layer setBorderWidth:2.0f];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColor = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0.5, 0,1 });
    [exitButton.layer setBorderColor:borderColor];
    CGColorRelease(borderColor);
    [self.view addSubview:exitButton];
    
    [exitButton addTarget:self action:@selector(exitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

- (void)exitButtonAction:(UIButton *)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"乃确定不是手滑了嘛？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"手滑了" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [AVUser logOut];
        ElLoginViewController *loginView = [[ElLoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
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
