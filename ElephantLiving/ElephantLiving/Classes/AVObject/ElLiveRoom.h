//
//  ElLiveRoom.h
//  ElephantLiving
//
//  Created by dllo on 16/11/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseAVObject.h"

@interface ElLiveRoom : ElBaseAVObject

/**
 *  拉流地址
 */
@property (nonatomic, strong) NSString *pullUrl;
/**
 *  主播名称
 */
@property (nonatomic, strong) NSString *host_name;
/**
 *  主播id
 */
@property (nonatomic, strong) NSString *userObjectId;
/**
 *  主播图像
 */
@property (nonatomic, strong) NSString *headerImage;
/**
 *  封面图片
 */
@property (nonatomic, strong) NSString *coverImage;
/**
 *  主播等级
 */
@property (nonatomic, strong) NSNumber *level;
/**
 *  观看人数
 */
@property (nonatomic, assign) NSInteger view_count;
/**
 *  直播间标题
 */
@property (nonatomic, strong) NSString *liveRoom_title;




@end
