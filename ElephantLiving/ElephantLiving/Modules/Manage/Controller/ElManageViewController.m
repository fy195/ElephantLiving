//
//  ElManageViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElManageViewController.h"

@interface ElManageViewController ()

@end

@implementation ElManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 64)];
    titleLabel.text = @"直播间管理";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
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
    
    UILabel *myLiveRoomLabel = [[UILabel alloc] initWithFrame:CGRectMake(returnButton.x, lineLabel.y , SCREEN_WIDTH - returnButton.x - returnButton.width, returnButton.height)];
    myLiveRoomLabel.text = @"我的直播间";
    myLiveRoomLabel.textAlignment = NSTextAlignmentLeft;
    myLiveRoomLabel.textColor = [UIColor blackColor];
    myLiveRoomLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:myLiveRoomLabel];
    
    UIView *roomView = [[UIView alloc] initWithFrame:CGRectMake(0, myLiveRoomLabel.y + myLiveRoomLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT / 5)];
    roomView.layer.borderWidth = 1;
    roomView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:roomView];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(returnButton.x, 5, roomView.height / 2, roomView.height / 2)];
    headImage.backgroundColor = [UIColor yellowColor];
    [roomView addSubview:headImage];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImage.x * 2+ headImage.width, 0, SCREEN_WIDTH / 2, myLiveRoomLabel.height)];
    nameLabel.text = [NSString stringWithFormat:@"...的直播间"];
    nameLabel.centerY = headImage.centerY;
    [roomView addSubview:nameLabel];
    
    UIButton *enterRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterRoomButton.frame = CGRectMake(headImage.width / 2, 0, SCREEN_WIDTH / 3, nameLabel.height);
    enterRoomButton.centerY = (roomView.height + headImage.y + headImage.height) / 2;
    [enterRoomButton setTitle:@"进入直播间" forState:UIControlStateNormal];
    [enterRoomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    enterRoomButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    enterRoomButton.layer.borderWidth = 1;
    enterRoomButton.layer.cornerRadius = 15;
    enterRoomButton.clipsToBounds = YES;
    enterRoomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [roomView addSubview:enterRoomButton];
    
    UIButton *settingManagerButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - enterRoomButton.x - enterRoomButton.width, enterRoomButton.y, enterRoomButton.width, enterRoomButton.height)];
    [settingManagerButton setTitle:@"设置管理员" forState:UIControlStateNormal];
    [settingManagerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    settingManagerButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    settingManagerButton.layer.borderWidth = 1;
    settingManagerButton.layer.cornerRadius = 15;
    settingManagerButton.clipsToBounds = YES;
    settingManagerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [roomView addSubview:settingManagerButton];
    
    
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
