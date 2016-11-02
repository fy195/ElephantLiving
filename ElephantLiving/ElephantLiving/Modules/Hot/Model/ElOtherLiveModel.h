//
//  ElOtherLiveModel.h
//  ElephantLiving
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseModel.h"

@interface ElOtherLiveModel : ElBaseModel
/**
 *  当前直播观看人数
 */
@property (nonatomic, strong) NSNumber *allnum;
/**
 *  直播拉留地址
 */
@property (nonatomic, strong) NSString *flv;
/**
 *  主播昵称
 */
@property (nonatomic, strong) NSString *myname;
/**
 *  主播等级
 */
@property (nonatomic, strong) NSNumber *starlevel;
/**
 *  主播头像
 */
@property (nonatomic, strong) NSString *smallpic;
/**
 *  直播封面
 */
@property (nonatomic, strong) NSString *bigpic;


@end
