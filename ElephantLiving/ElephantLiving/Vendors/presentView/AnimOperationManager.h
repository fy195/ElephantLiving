//
//  AnimOperationManager.h
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftModel.h"

@interface AnimOperationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong) UIView *parentView;

@property (nonatomic,strong) GiftModel *model;
/// 动画操作 : 需要UserID和回调
- (void)animWithUserID:(NSString *)userID model:(GiftModel *)model finishedBlock:(void(^)(BOOL result))finishedBlock;

/// 取消上一次的动画操作
- (void)cancelOperationWithLastUserID:(NSString *)userID;

@end
