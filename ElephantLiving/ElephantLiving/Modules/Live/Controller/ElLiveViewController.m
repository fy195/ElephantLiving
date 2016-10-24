//
//  ElLiveViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ElLiveViewController ()
@property (nonatomic, weak) UIView *playView;
@property (nonatomic, strong)  IJKFFMoviePlayerController *moviePlayer;
@end

@implementation ElLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playFlv];
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
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    NSString *flv = @"http://hdl.9158.com/live/5717d4fd5f189d5ddaa8d5c78df2e895.flv";
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

@end
