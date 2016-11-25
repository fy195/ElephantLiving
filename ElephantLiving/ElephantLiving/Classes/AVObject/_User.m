//
//  _User.m
//  ElephantLiving
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "_User.h"

@implementation _User

- (void)setLevel:(NSNumber *)level {
    if (_level != level) {
        _level = level;
        [self setObject:_level forKey:@"level"];
    }
}

- (void)setFollower_count:(NSNumber *)follower_count {
    if (_follower_count != follower_count) {
        _follower_count = follower_count;
        [self setObject:_follower_count forKey:@"follower_count"];
    }
}

- (void)setFollow_count:(NSNumber *)follow_count {
    if (_follow_count != follow_count) {
        _follow_count = follow_count;
        [self setObject:_follow_count forKey:@"follow_count"];
    }
}
- (void)setHeadImage:(NSString *)headImage {
    if (_headImage != headImage) {
        _headImage = headImage;
        [self setObject:_headImage forKey:@"headImage"];
    }
}

- (void)setSendGift:(NSNumber *)sendGift {
    if (_sendGift != sendGift) {
        _sendGift = sendGift;
        [self setObject:sendGift forKey:@"sendGift"];
    }
}

- (void)setReceiveGift:(NSNumber *)receiveGift {
    if (_receiveGift != receiveGift) {
        _receiveGift = receiveGift;
        [self setObject:receiveGift forKey:@"receiveGift"];
    }
}

- (void)setLivingTime:(NSInteger)livingTime {
    if (_livingTime != livingTime) {
        _livingTime = livingTime;
        [self setObject:[NSNumber numberWithInteger:livingTime] forKey:@"livingTime"];
    }
}

- (void)setCharm:(NSInteger)charm {
    if (_charm != charm) {
        _charm = charm;
        [self setObject:[NSNumber numberWithInteger:charm] forKey:@"charm"];
    }
}

@end