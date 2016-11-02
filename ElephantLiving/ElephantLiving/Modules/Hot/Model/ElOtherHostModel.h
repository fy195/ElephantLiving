//
//  ElOtherHostModel.h
//  ElephantLiving
//
//  Created by dllo on 16/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseModel.h"

@interface ElOtherHostModel : ElBaseModel
/**
 *  关注
 */
@property (nonatomic, strong) NSNumber *friendnum;
/**
 *  粉丝
 */
@property (nonatomic, strong) NSNumber *fansnum;
/**
 *  送出的礼物
 */
@property (nonatomic, strong) NSNumber *sendgift;
/**
 *  收到的礼物
 */
@property (nonatomic, strong) NSNumber *catfood;

@end
