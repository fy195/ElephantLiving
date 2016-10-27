//
//  ElLiveViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ElStartLiving.h"

@interface ElLiveViewController ()

@property (nonatomic, strong) ElStartLiving *startView;

@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) NSTimer *MyTimer;

@property (nonatomic, assign) NSInteger timeNumber;


@end

@implementation ElLiveViewController

- (void)viewWillAppear:(BOOL)animated {

    _startView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor cyanColor];
    self.startView = [[ElStartLiving alloc] initWithFrame:self.view.bounds];
    _startView.hidden = NO;
    [self.view addSubview:_startView];
    [_startView.startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_startView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _timeImageView.center = self.view.center;
    _timeImageView.backgroundColor = [UIColor clearColor];
    
}



- (void)startButtonAction:(UIButton *)startButton {

    _startView.hidden = YES;

    [self.view addSubview:_timeImageView];
    [self openCountdown];
}

- (void)backButtonAction:(UIButton *)backButton {
    
    self.tabBarController.selectedIndex = 0;
//    for (UIButton *button in self.tabBarController.tabBar.subviews) {
//        NSLog(@"11");
//        if (button.tag == 1000) {
//            NSLog(@"22");
//            button.selected = YES;
//        }
//    }
    
}
-(void)openCountdown{
    
    __block NSInteger time = 3; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self countdownEnd];
            });
        }else{
            int seconds = time % 4;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self inTheCountdown:seconds];
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//  倒计时结束
- (void)countdownEnd {
    
    NSLog(@"倒计时完毕");
    [_timeImageView removeFromSuperview];
    
    self.timeNumber = 0;
    self.MyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

//  倒计时中
- (void)inTheCountdown: (int)seconds {
    
    NSLog(@"倒计时%d",seconds);
    _timeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"time%d",seconds]];
    [UIView animateWithDuration:0.95 animations:^{
        _timeImageView.frame = CGRectMake(0, 0, 200, 200);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 0.5;
    } completion:^(BOOL finished) {
        _timeImageView.frame = CGRectMake(0, 0, 10, 10);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 1;
    }];
    
}
- (void) timerAction {
    
    _timeNumber++;
    
}
//  直播时长
- (void)timeEnd {
    
    NSInteger tempHour = _timeNumber / 3600;
    NSInteger tempMinute = _timeNumber / 60 - (tempHour * 60);
    NSInteger tempSecond = _timeNumber - (tempHour * 3600 + tempMinute * 60);
    NSString *hour = [[NSNumber numberWithInteger:tempHour] stringValue];
    NSString *minute = [[NSNumber numberWithInteger:tempMinute] stringValue];
    NSString *second = [[NSNumber numberWithInteger:tempSecond] stringValue];
    if (tempHour < 10) {
        hour = [@"0" stringByAppendingString:hour];
    }
    if (tempMinute < 10) {
        minute = [@"0" stringByAppendingString:minute];
    }
    if (tempSecond < 10) {
        second = [@"0" stringByAppendingString:second];
    }
    NSLog(@"%@:%@:%@",hour,minute,second);
    [_MyTimer invalidate];
}


@end
