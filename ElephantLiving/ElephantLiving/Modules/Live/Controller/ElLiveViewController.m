//
//  ElLiveViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveViewController.h"
#import "ElStartLiving.h"
#import <QPLive/QPLive.h>
//#import <CoreTelephony/CTCallCenter.h>
//#import <CoreTelephony/CTCall.h>

@interface ElLiveViewController ()
<
QPLiveSessionDelegate
>

@property (nonatomic, strong) ElStartLiving *startView;

@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) NSTimer *myTimer;

@property (nonatomic, assign) NSInteger timeNumber;

@property (nonatomic, strong) NSString *pushUrl;

@property (nonatomic, strong) NSString *pullUrl;

//@property (nonatomic, strong) CTCallCenter *callCenter;

@property (nonatomic, strong) QPLiveSession *liveSession;;

@property (nonatomic, strong) QPLConfiguration *configuration;

@end

@implementation ElLiveViewController{
    QPLiveSession *_liveSession;
    AVCaptureDevicePosition _currentPosition;
//    BOOL _isCTCallStateDisconnected;
}

- (void)viewWillAppear:(BOOL)animated {
    _startView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.startView = [[ElStartLiving alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_startView];
    [_startView.startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_startView.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _timeImageView.center = self.view.center;
    _timeImageView.backgroundColor = [UIColor clearColor];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive) name:UIApplicationWillResignActiveNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.view addGestureRecognizer:gesture];
    
    [self createRequest];
    [self createConfiguration];
    
}

// 聚焦
- (void)tapGesture:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:self.view];
    CGPoint percentPoint = CGPointZero;
    percentPoint.x = point.x / CGRectGetWidth(self.view.bounds);
    percentPoint.y = point.y / CGRectGetHeight(self.view.bounds);
    [_liveSession focusAtAdjustedPoint:percentPoint autoFocus:YES];
}

//- (void)appResignActive{
//    [self destroySession];
//    // 监听电话
//    _callCenter = [[CTCallCenter alloc] init];
//    _isCTCallStateDisconnected = NO;
//    _callCenter.callEventHandler = ^(CTCall* call) {
//        if ([call.callState isEqualToString:CTCallStateDisconnected]) {
//            _isCTCallStateDisconnected = YES;
//        }else if([call.callState isEqualToString:CTCallStateConnected]) {
//            _callCenter = nil;
//        }
//    };
//}
//
//- (void)appBecomeActive{
//    if (_isCTCallStateDisconnected) {
//        sleep(2);
//    }
//    [self createConfiguration];
//}


- (void)createRequest {
    QPLiveRequest *request = [[QPLiveRequest alloc] init];
    [request requestCreateLiveWithDomain:kELDomain success:^(NSString *pushUrl, NSString *pullUrl) {
        self.pushUrl = pushUrl;
        _configuration.url = pushUrl;
        self.pullUrl = pullUrl;
        NSLog(@"%@", pullUrl);
    } failure:^(NSError *error) {
        UIAlertController *alerat = [UIAlertController alertControllerWithTitle:@"" message:@"Create Live Failed" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alerat addAction:action];
    }];
}

- (void)createConfiguration {
    QPLConfiguration *configuration = [[QPLConfiguration alloc] init];
    configuration.url = _pushUrl;
    configuration.videoMaxBitRate = 1500 * 1000;
    configuration.videoBitRate = 600 * 1000;
    configuration.videoMinBitRate = 400 * 1000;
    configuration.audioBitRate = 64 * 1000;
    configuration.videoSize = CGSizeMake(360, 640);// 横屏状态宽高不需要互换
    configuration.fps = 20;
    configuration.preset = AVCaptureSessionPresetiFrame1280x720;
    configuration.screenOrientation = 0;
    self.configuration = configuration;
    
    // 水印
    configuration.waterMaskImage = [UIImage imageNamed:@"水印"];
    configuration.waterMaskLocation = 0;
    configuration.waterMaskMarginX = 20;
    configuration.waterMaskMarginY = 20;
    
    if (_currentPosition) {
        configuration.position = _currentPosition;
    }else {
        configuration.position = AVCaptureDevicePositionFront;
        _currentPosition = AVCaptureDevicePositionFront;
    }
    
    self.liveSession = [[QPLiveSession alloc] initWithConfiguration:configuration];
    _liveSession.delegate = self;
    [_liveSession startPreview];
    [_liveSession setEnableSkin:YES];
    [_liveSession updateConfiguration:^(QPLConfiguration *configuration) {
        configuration.videoMaxBitRate = 1500 * 1000;
        configuration.videoBitRate = 600 * 1000;
        configuration.videoMinBitRate = 400 * 1000;
        configuration.audioBitRate = 64 * 1000;
        configuration.fps = 20;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view insertSubview:[_liveSession previewView] atIndex:0];
    });
}

- (void)startButtonAction:(UIButton *)startButton {
    _startView.hidden = YES;
        [self.view addSubview:_timeImageView];
        [self openCountdown];
}

- (void)destroySession{
    
    [_liveSession disconnectServer];
    
    [_liveSession stopPreview];
    [_liveSession.previewView removeFromSuperview];
    
    _liveSession = nil;
}

- (void)backButtonAction:(UIButton *)backButton {
    [_liveSession stopPreview];
    [_liveSession.previewView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
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
                [_liveSession connectServer];
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
    [_timeImageView removeFromSuperview];
    self.timeNumber = 0;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

//  倒计时中
- (void)inTheCountdown: (int)seconds {

    _timeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"time%d",seconds]];
    [UIView animateWithDuration:0.8 animations:^{
        _timeImageView.frame = CGRectMake(0, 0, 200, 200);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 1;
    } completion:^(BOOL finished) {
        _timeImageView.frame = CGRectMake(0, 0, 10, 10);
        _timeImageView.center = self.view.center;
        _timeImageView.alpha = 0.5;
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
    [_myTimer invalidate];
}

// session代理方法
- (void)liveSession:(QPLiveSession *)session error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *msg = [NSString stringWithFormat:@"%zd %@",error.code, error.localizedDescription];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Live Error" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"重新连接", nil];
        alertView.delegate = self;
        [alertView show];
    });
}


- (void)liveSessionNetworkSlow:(QPLiveSession *)session{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"网络太差" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

- (void)liveSessionConnectSuccess:(QPLiveSession *)session {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"连接成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

- (void)openAudioSuccess:(QPLiveSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"麦克风打开成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

- (void)openVideoSuccess:(QPLiveSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"YES" message:@"摄像头打开成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}


- (void)liveSession:(QPLiveSession *)session openAudioError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"麦克风获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

- (void)liveSession:(QPLiveSession *)session openVideoError:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"摄像头获取失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

- (void)liveSession:(QPLiveSession *)session encodeAudioError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"音频编码初始化失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
    
}

- (void)liveSession:(QPLiveSession *)session encodeVideoError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"视频编码初始化失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    });
}

//- (IBAction)buttonCloseClick:(id)sender {
//    [self destroySession];
//    [_myTimer invalidate];
//    _myTimer = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//- (IBAction)cameraButtonClick:(UIButton *)button {
//    button.selected = !button.isSelected;
//    _liveSession.devicePosition = button.isSelected ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
//    _currentPosition = _liveSession.devicePosition;
//}
//
//- (IBAction)skinButtonClick:(UIButton *)button {
//    button.selected = !button.isSelected;
//    [_liveSession setEnableSkin:button.isSelected];
//}
//- (IBAction)flashButtonClick:(UIButton *)button {
//    button.selected = !button.isSelected;
//    _liveSession.torchMode = button.isSelected ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
//}
//
//
//- (IBAction)disconnectButtonClick:(id)sender {
//    if (_liveSession.dumpDebugInfo.connectStatus == QPLConnectStatusNone) {
//        [_liveSession connectServer];
//    }else{
//        [_liveSession disconnectServer];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
