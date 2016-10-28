//
//  ElEndLiving.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElEndLiving.h"
#import "ElMacro.h"

@implementation ElEndLiving

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 模糊效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = self.frame;
        [self addSubview:effectView];
        
        
        self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.15, SCREEN_WIDTH * 0.4, SCREEN_HEIGHT * 0.08)];
        _endLabel.text = @"直播已结束";
        _endLabel.font = [UIFont systemFontOfSize:30];
        _endLabel.textColor = [UIColor cyanColor];
        _endLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_endLabel];
        
        
        self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, SCREEN_HEIGHT * 0.23, SCREEN_WIDTH * 0.245, SCREEN_HEIGHT * 0.05)];
        _timeTextLabel.text = @"直播时长";
        _timeTextLabel.font = [UIFont systemFontOfSize:20];
        _timeTextLabel.textColor = [UIColor lightGrayColor];
        _timeTextLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeTextLabel];
        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.505, SCREEN_HEIGHT * 0.23, SCREEN_WIDTH * 0.245, SCREEN_HEIGHT * 0.05)];
        _timeLabel.textColor = [UIColor cyanColor];
        _timeLabel.font = [UIFont systemFontOfSize:20];
        _timeLabel.text = @"00:00:00";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLabel];
        
        
        self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.35, SCREEN_HEIGHT * 0.33, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.1)];
        _viewLabel.text = @"999999";
        _viewLabel.font = [UIFont systemFontOfSize:25];
        _viewLabel.textAlignment = NSTextAlignmentCenter;
        _viewLabel.textColor = [UIColor cyanColor];
        [self addSubview:_viewLabel];
        
        
        self.viewTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.38, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.08)];
        _viewTextLabel.text = @"看过宝宝的直播，棒棒哒！";
        _viewTextLabel.font = [UIFont systemFontOfSize:19];
        _viewTextLabel.textAlignment = NSTextAlignmentCenter;
        _viewTextLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_viewTextLabel];
        
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.5, SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.02)];
        lineImageView.image = [UIImage imageNamed:@"me_line_"];
        [self addSubview:lineImageView];
        
        
        UIButton *qqzoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qqzoneButton.frame = CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
        [qqzoneButton setImage:[UIImage imageNamed:@"share_qqzone"] forState:UIControlStateNormal];
        [self addSubview:qqzoneButton];
        
        
        UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qqButton.frame = CGRectMake(SCREEN_WIDTH * 0.32, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
        [qqButton setImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
        [self addSubview:qqButton];
        
        
        UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weiboButton.frame = CGRectMake(SCREEN_WIDTH * 0.44, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
        [weiboButton setImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateNormal];
        [self addSubview:weiboButton];
        
        
        
        UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        weixinButton.frame = CGRectMake(SCREEN_WIDTH * 0.56, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
//        weixinButton.backgroundColor = [UIColor redColor];
        [weixinButton setImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
        [self addSubview:weixinButton];
        
        
        
        UIButton *momentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        momentsButton.frame = CGRectMake(SCREEN_WIDTH * 0.68, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
//        momentsButton.backgroundColor = [UIColor redColor];
        [momentsButton setImage:[UIImage imageNamed:@"share_moments"] forState:UIControlStateNormal];
        [self addSubview:momentsButton];
        
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(SCREEN_WIDTH *0.1, SCREEN_HEIGHT *0.6, SCREEN_WIDTH *0.8, SCREEN_HEIGHT * 0.08);
        [_backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"button_bg_large_borders"] forState:UIControlStateNormal];
        [self addSubview:_backButton];  
    }
    return self;
}

@end
