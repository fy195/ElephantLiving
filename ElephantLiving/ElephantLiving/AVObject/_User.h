//
//  _User.h
//  ElephantLiving
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseAVUser.h"

@interface _User : ElBaseAVUser

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
@property (nonatomic, assign) NSInteger charm;
/**
 *  头像
 */
@property (nonatomic, strong) NSString *headImage;



@end
