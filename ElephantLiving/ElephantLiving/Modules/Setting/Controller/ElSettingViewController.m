//
//  ElSettingViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElSettingViewController.h"
#import "ElLoginViewController.h"

@interface ElSettingViewController ()

@end

@implementation ElSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9255 green:0.9255 blue:0.9373 alpha:1.0];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 20)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 64)];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.y + titleLabel.height, SCREEN_WIDTH, 0.5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor yellowColor];
    returnButton.frame = CGRectMake(20, 40, 40, 40);
    returnButton.centerY = titleLabel.centerY;
    [self.view addSubview:returnButton];
    
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    
    
    
    
    
    
    UIView *livingView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.y * 2+ titleLabel.height , titleLabel.width, titleLabel.height / 3 * 2)];
    livingView.layer.borderWidth = 1;
    livingView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    livingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:livingView];
    
    UILabel *livingLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x, 0, SCREEN_WIDTH, livingView.height)];
    livingLabel.text = @"开播提醒";
    livingLabel.textAlignment = NSTextAlignmentLeft;
    [livingView addSubview:livingLabel];
    
    UISwitch *livingSwitch = [[UISwitch alloc] init];
    livingSwitch.frame = CGRectMake(SCREEN_WIDTH - livingSwitch.width - livingLabel.x, 0, 0, 0);
    livingSwitch.centerY = livingLabel.centerY;
    [livingView addSubview:livingSwitch];
    
    
    
    
    
    
    UILabel *livingTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x * 2,livingView.y + livingView.height, SCREEN_WIDTH - returnButton.x * 2, livingView.height / 2)];
    livingTextLabel.text = @"开启后,你关注的主播开播时你会收到通知";
    livingTextLabel.textAlignment = NSTextAlignmentLeft;
    livingTextLabel.textColor = [UIColor lightGrayColor];
    livingTextLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:livingTextLabel];
    
    
    UIView *messageView = [[UIView alloc] initWithFrame:CGRectMake(0, livingView.y + livingView.height * 2, livingView.width, livingView.height)];
    messageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    messageView.layer.borderWidth = 1;
    messageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:messageView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x, 0, SCREEN_WIDTH, messageView.height)];
    messageLabel.text = @"公聊消息过滤";
    messageLabel.textAlignment = NSTextAlignmentLeft;
    [messageView addSubview:messageLabel];
    
    UISwitch *messagesSwitch = [[UISwitch alloc] init];
    messagesSwitch.frame = CGRectMake(livingSwitch.x, livingSwitch.height, 0, 0);
    messagesSwitch.centerY = messageLabel.centerY;
    [messageView addSubview:messagesSwitch];
    
    UILabel *messageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(livingTextLabel.x, messageView.y + messageView.height, livingTextLabel.width, livingTextLabel.height)];
    messageTextLabel.text = @"开启后,显示当前主播和你相关的公聊消息";
    messageTextLabel.textAlignment = NSTextAlignmentLeft;
    messageTextLabel.textColor = [UIColor lightGrayColor];
    messageTextLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:messageTextLabel];
    
    
    UIButton *cacheButton= [UIButton buttonWithType:UIButtonTypeCustom];
    cacheButton.frame = CGRectMake(0, messageView.y + messageView.height * 2, messageView.width, messageView.height);
    cacheButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cacheButton.layer.borderWidth = 1;
    cacheButton.backgroundColor = [UIColor whiteColor];
    
    UILabel *cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x, 0, SCREEN_WIDTH, cacheButton.height)];
    cacheLabel.text = @"清除缓存";
    cacheLabel.textAlignment = NSTextAlignmentLeft;
    [cacheButton addSubview:cacheLabel];
    
    [self.view addSubview:cacheButton];
    
   
    
    
    
    
    
    
    UIButton *aboutUs = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUs.frame = CGRectMake(0, cacheButton.y + cacheButton.height * 2, cacheButton.width, cacheButton.height);
    aboutUs.layer.borderWidth = 1;
    aboutUs.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    aboutUs.backgroundColor = [UIColor whiteColor];
    
    UILabel *aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x, 0, SCREEN_WIDTH, aboutUs.height)];
    aboutUsLabel.text = @"关于我们";
    aboutUsLabel.textAlignment = NSTextAlignmentLeft;
    [aboutUs addSubview:aboutUsLabel];
    
    [self.view addSubview:aboutUs];
    
    
    
    
    
    
    
    UILabel *bottomLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - titleLabel.height - 1, SCREEN_WIDTH, 1)];
    bottomLineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomLineLabel];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(0, SCREEN_HEIGHT - titleLabel.height, SCREEN_WIDTH, titleLabel.height);
    exitButton.backgroundColor = [UIColor whiteColor];
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:exitButton];
    
    [exitButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        ElLoginViewController *loginView = [[ElLoginViewController alloc] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }];
    
    
    // Do any additional setup after loading the view.
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
