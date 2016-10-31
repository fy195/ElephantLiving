//
//  ElUser.m
//  ElephantLiving
//
//  Created by dllo on 16/10/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElUser.h"

@implementation ElUser

+ (instancetype)shareUser {
    static ElUser *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[ElUser alloc] init];
    });
    return user;
}

@end
