//
//  ElBaseModel.h
//  ElephantLiving
//
//  Created by dllo on 16/10/19.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVObject;

@interface ElBaseModel : NSObject

@property (nonatomic, strong)AVObject *mapAVObject;
/**
 *  基类初始化方法
 *
 *  @param dic model对应的字典
 *
 *  @return
 */
- (instancetype)initWithDic:(NSDictionary *)dic;
/**
 *  基类构造器方法
 *
 *  @param dic model对应的字典
 *
 *  @return
 */
+ (instancetype)modelWithDic:(NSDictionary *)dic;

+ (NSArray *)modelArrayWithArray:(NSArray *)avObjectArray;
@end
