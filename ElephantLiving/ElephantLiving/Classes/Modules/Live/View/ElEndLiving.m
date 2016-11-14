//
//  ElEndLiving.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElEndLiving.h"
#import "ElMacro.h"

@interface ElEndLiving ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *viewLabel;
@end

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
        
        
        self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.3, SCREEN_HEIGHT * 0.15, SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.08)];
        _endLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.19);
        _endLabel.text = @"直播已结束";
        _endLabel.font = [UIFont systemFontOfSize:28];
        _endLabel.textColor = [UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1];
        _endLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_endLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.7, SCREEN_HEIGHT * 0.05)];
        _timeLabel.textColor = [UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:20];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLabel];
        
        
        self.viewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.33, SCREEN_WIDTH, SCREEN_WIDTH * 0.1)];
        _viewLabel.text = @"0位观众";
        _viewLabel.font = [UIFont systemFontOfSize:25];
        _viewLabel.textAlignment = NSTextAlignmentCenter;
        _viewLabel.textColor = [UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1];
        [self addSubview:_viewLabel];
        
        
        self.viewTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.7, SCREEN_WIDTH * 0.08)];
        _viewTextLabel.text = @"看过宝宝的直播，棒棒哒！";
        _viewTextLabel.numberOfLines = 0;
        [_viewTextLabel sizeToFit];
        _viewTextLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.42);
        _viewTextLabel.font = [UIFont systemFontOfSize:17];
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
        [weixinButton setImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
        [self addSubview:weixinButton];
        
        
        
        UIButton *momentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        momentsButton.frame = CGRectMake(SCREEN_WIDTH * 0.68, SCREEN_HEIGHT * 0.52, SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.12);
        [momentsButton setImage:[UIImage imageNamed:@"share_moments"] forState:UIControlStateNormal];
        [self addSubview:momentsButton];
        
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(SCREEN_WIDTH *0.1, SCREEN_HEIGHT *0.65, SCREEN_WIDTH *0.8, SCREEN_HEIGHT * 0.08);
        [_backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor colorWithRed:1 green:0.74 blue:0.15 alpha:1] forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = SCREEN_HEIGHT * 0.08 / 2;
        [_backButton.layer setBorderWidth:2.0f];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColor = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0.74, 0.15,1 });
        [_backButton.layer setBorderColor:borderColor];
        CGColorRelease(borderColor);
        [self addSubview:_backButton];  
    }
    return self;
}

- (void)setTime:(NSString *)time {
    if (_time != time) {
        _time = time;
    }
    _timeLabel.text = [NSString stringWithFormat:@"直播时长:%@", time];
    _timeLabel.numberOfLines = 0;
    [_timeLabel sizeToFit];
    _timeLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.255);
    NSRange range = [_timeLabel.text rangeOfString:@":"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_timeLabel.text]];
    NSRange range1 = NSMakeRange(0, range.location + 1);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
    [_timeLabel setAttributedText:str];
}

- (void)setView_count:(NSInteger)view_count {
    if (_view_count != view_count) {
        _view_count = view_count;
        _viewLabel.text = [NSString stringWithFormat:@"%ld位观众", view_count];
//        _viewLabel.numberOfLines = 0;
//        [_viewLabel sizeToFit];
////        _viewLabel.center = CGPointMake(SCREEN_WIDTH * 0.5, _viewLabel.y + _viewLabel.height / 2);
        _viewLabel.textAlignment = NSTextAlignmentCenter;
    }
}

@end
