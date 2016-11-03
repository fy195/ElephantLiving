//
//  AnimOperation.h
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentView.h"
#import "GiftModel.h"

@interface AnimOperation : NSOperation

@property (nonatomic,strong) PresentView *presentView;

@property (nonatomic,strong) UIView *listView;

@property (nonatomic,strong) GiftModel *model;

@property (nonatomic,assign) NSInteger index;
// 新增用户唯一标示，记录礼物信息
@property (nonatomic,copy) NSString *userID;

// 回调参数增加了结束时礼物累计数
+ (instancetype)animOperationWithUserID:(NSString *)userID model:(GiftModel *)model finishedBlock:(void(^)(BOOL result,NSInteger finishCount))finishedBlock;


@end
