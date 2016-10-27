//
//  ElWatchViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/10/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElWatchViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>


@interface ElWatchViewController ()
@property (nonatomic, weak) UIView *playView;
@property (nonatomic, strong)  IJKFFMoviePlayerController *moviePlayer;
@end

@implementation ElWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [options setPlayerOptionIntValue:1 forKey:@"audiotoolbox"];
    [options setPlayerOptionIntValue:15 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    NSString *flv = @"http://play.lss.qupai.me/elephantliving/elephantliving-20RUS.flv?auth_key=1477651840-0-2783-b847733f4e738309bfd9d82e0e1aa5e4.flv";
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
