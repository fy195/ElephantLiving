//
//  ElConfiguration.m
//  ElephantLiving
//
//  Created by dllo on 16/10/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElConfiguration.h"
#import <QPLive/QPLive.h>

@interface ElConfiguration ()

@property (nonatomic, strong)  QPLConfiguration *configuration;

@end

@implementation ElConfiguration

- (instancetype)initConfiguration {
    self = [super init];
    if (self) {
        self.configuration = [[QPLConfiguration alloc] init];
    }
    return self;
}

- (void)setPreset:(NSString *)preset {
    if (_preset != preset) {
        _preset = preset;
    }
    _configuration.preset = preset;
}

- (void)setPosition:(AVCaptureDevicePosition)position {
    if (_position != position) {
        _position = position;
    }
    _configuration.position = position;
}

- (void)setVideoSize:(CGSize)videoSize {
    _configuration.videoSize = videoSize;
}

- (void)setUrl:(NSString *)url {
    if (_url != url) {
        _url = url;
    }
    _configuration.url = url;
}

- (void)setWaterMaskLocation:(QP_LIVE_WATERMASK_LOCATION)waterMaskLocation {
    if (_waterMaskLocation != waterMaskLocation) {
        _waterMaskLocation = waterMaskLocation;
    }
    _configuration.waterMaskLocation = waterMaskLocation;
}

- (void)setWaterMaskImage:(UIImage *)waterMaskImage {
    if (_waterMaskImage != waterMaskImage) {
        _waterMaskImage = waterMaskImage;
    }
    _configuration.waterMaskImage = waterMaskImage;
}

- (void)setWaterMaskMarginX:(CGFloat)waterMaskMarginX {
    if (_waterMaskMarginX != waterMaskMarginX) {
        _waterMaskMarginX = waterMaskMarginX;
    }
    _configuration.waterMaskMarginX = waterMaskMarginX;
}

- (void)setWaterMaskMarginY:(CGFloat)waterMaskMarginY {
    if (_waterMaskMarginY != _waterMaskMarginY) {
        _waterMaskMarginY = waterMaskMarginY;
    }
    _configuration.waterMaskMarginY = waterMaskMarginY;
}

- (void)setVideoMaxBitRate:(NSInteger)videoMaxBitRate {
    if (_videoMaxBitRate != videoMaxBitRate) {
        _videoMaxBitRate = videoMaxBitRate;
    }
    _configuration.videoMaxBitRate = videoMaxBitRate;
}

- (void)setVideoMinBitRate:(NSInteger)videoMinBitRate {
    if (_videoMinBitRate != videoMinBitRate) {
        _videoMinBitRate = videoMinBitRate;
    }
    _configuration.videoMinBitRate = videoMinBitRate;
}

- (void)setVideoBitRate:(NSInteger)videoBitRate {
    if (_videoBitRate != videoBitRate) {
        _videoBitRate = videoBitRate;
    }
    _configuration.videoBitRate = videoBitRate;
}

- (void)setAudioBitRate:(NSInteger)audioBitRate {
    if (_audioBitRate != audioBitRate) {
        _audioBitRate = audioBitRate;
    }
    _configuration.audioBitRate = audioBitRate;
}

- (void)setFps:(NSInteger)fps {
    if (_fps != fps) {
        _fps = fps;
    }
    _configuration.fps = fps;
}













@end
