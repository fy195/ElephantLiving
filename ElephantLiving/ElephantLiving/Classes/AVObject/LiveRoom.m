//
//  LiveRoom.m
//  ElephantLiving
//
//  Created by dllo on 16/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LiveRoom.h"

@implementation LiveRoom

- (void)setLevel:(NSNumber *)level {
    if (_level != level) {
        _level = level;
        [self setObject:_level forKey:@"level"];
    }
}

- (void)setLiveRoom_title:(NSString *)liveRoom_title {
    if (_liveRoom_title != liveRoom_title) {
        _liveRoom_title = liveRoom_title;
        [self setObject:_liveRoom_title forKey:@"liveRoom_title"];
    }
}

- (void)setPullUrl:(NSString *)pullUrl {
    if (_pullUrl != pullUrl) {
        _pullUrl = pullUrl;
        [self setObject:_pullUrl forKey:@"pullUrl"];
    }
}

- (void)setHost_name:(NSString *)host_name {
    if (_host_name != host_name) {
        _host_name = host_name;
        [self setObject:_host_name forKey:@"host_name"];
    }
}

- (void)setHeaderImage:(NSString *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
        [self setObject:_headerImage forKey:@"headerImage"];
    }
}

- (void)setCoverImage:(NSString *)coverImage {
    if (_coverImage != coverImage) {
        _coverImage = coverImage;
        [self setObject:_coverImage forKey:@"coverImage"];
    }
}

- (void)setUserObjectId:(NSString *)userObjectId {
    if (_userObjectId != userObjectId) {
        _userObjectId = userObjectId;
        [self setObject:userObjectId forKey:@"userObjectId"];
    }
}

- (void)setView_count:(NSInteger)view_count {
    if (_view_count != view_count) {
        _view_count = view_count;
        [self setObject:[NSNumber numberWithInteger:view_count] forKey:@"view_count"];
    }
}

@end
