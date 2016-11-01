//
//  ElWatchViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElWatchViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ElLivingTopView.h"
#import "ElLivingBottomToolView.h"

@interface ElWatchViewController ()
@property (nonatomic, weak) UIView *playView;
@property (nonatomic, strong)  IJKFFMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation ElWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self playFlv];
    [self creatTool];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.

}
- (void)creatTool {

    ElLivingTopView *topToolView = [ElLivingTopView elLivingTopView];
    topToolView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 57);
    topToolView.backgroundColor = [UIColor clearColor];
    [_moviePlayer.view addSubview:topToolView];
    
    ElLivingBottomToolView *bottomToolView = [ElLivingBottomToolView elLivingBottomToolView];
    bottomToolView.frame = CGRectMake(0, SCREEN_HEIGHT - 206, SCREEN_WIDTH, 206);
    bottomToolView.backgroundColor = [UIColor clearColor];
    [_moviePlayer.view addSubview:bottomToolView];
    [_moviePlayer.view bringSubviewToFront:bottomToolView];
    
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(SCREEN_WIDTH - 22 - 30, SCREEN_HEIGHT - 20 - 30, 30, 30);
    _closeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    _closeButton.layer.cornerRadius = 15.0;
    _closeButton.clipsToBounds = YES;
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"Home"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moviePlayer.view addSubview:_closeButton];
    [_moviePlayer.view bringSubviewToFront:_closeButton];

}

- (void)closeButtonAction:(UIButton *)button {
 
    [_moviePlayer shutdown];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playFlv {
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    [options setPlayerOptionIntValue:1 forKey:@"audiotoolbox"];
    [options setPlayerOptionIntValue:15 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    NSString *flv = @"http://pull99.a8.com/live/1477963017159850.flv?ikHost=ws&ikOp=1&CodecInfo=8192.flv";
    self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    _moviePlayer.view.frame = self.view.bounds;
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    _moviePlayer.shouldAutoplay = NO;
    _moviePlayer.shouldShowHudView = NO;
    
    [_moviePlayer prepareToPlay];
    NSLog(@"播放");
    [self initObserver];
    [self.view addSubview:_moviePlayer.view];
    
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)didFinish {
    NSLog(@"结束");
}

- (void)stateDidChange {
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
        }else{
            NSLog(@"网络状态不好");
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        NSLog(@"网速不佳暂停");
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
