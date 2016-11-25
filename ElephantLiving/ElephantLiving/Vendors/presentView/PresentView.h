//
//  PresentView.h
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShakeLabel.h"
#import "GiftModel.h"

typedef void(^completeBlock)(BOOL finished, NSInteger finishCount);

@interface PresentView : UIView

@property (nonatomic,strong) GiftModel *model;
// 头像
@property (nonatomic,strong) UIImageView *headImageView;
// 礼物
@property (nonatomic,strong) UIImageView *giftImageView;
// 送礼物者
@property (nonatomic,strong) UILabel *nameLabel;
// 礼物名称
@property (nonatomic,strong) UILabel *giftLabel;
// 礼物个数
@property (nonatomic,assign) NSInteger giftCount;

@property (nonatomic,strong) ShakeLabel *skLabel;
// 动画执行到了第几次
@property (nonatomic,assign) NSInteger animCount;
// 记录原始坐标
@property (nonatomic,assign) CGRect originFrame;

@property (nonatomic,assign,getter=isFinished) BOOL finished;

- (void)animateWithCompleteBlock:(completeBlock)completed;

- (void)shakeNumberLabel;

- (void)hidePresendView;

@end
