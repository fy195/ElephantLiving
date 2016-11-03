//
//  ElUser.h
//  ElephantLiving
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface ElUser : AVUser
/**
 *  用户等级
 */
@property (nonatomic, strong) NSNumber *level;
/**
 *  粉丝数
 */
@property (nonatomic, strong) NSNumber *follower_count;
/**
 *  关注数
 */
@property (nonatomic, strong) NSNumber *follow_count;
/**
 *  魅力值
 */
@property (nonatomic, strong) NSNumber *charm;


@end


/**
 *  收到的礼物
 */
//[userInfo setObject:@"" forKey:@"receive_gift"];
/**
 *  送出的礼物
 */
//[userInfo setObject:@"" forKey:@"send_gift"];
/**
 *  用户头像
 */
//[userInfo setObject:@"" forKey:@"headimage"];
/**
 *  直播封面
 */
//[userInfo setObject:@"" forKey:@"coverimage"];
