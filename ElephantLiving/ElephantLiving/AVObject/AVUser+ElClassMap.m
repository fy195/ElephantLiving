//
//  AVUser+ElClassMap.m
//  ElephantLiving
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AVUser+ElClassMap.h"

@implementation AVUser (ElClassMap)


+(NSString *)userTag
{
    return @"_User";
}
+ (instancetype)user
{
    Class class = NSClassFromString(@"_User");
    return  [[class  alloc] initWithClassName:[[self class] userTag]];;
}

@end
