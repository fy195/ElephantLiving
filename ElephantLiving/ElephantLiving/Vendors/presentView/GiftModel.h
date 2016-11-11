//
//  GiftModel.h
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftModel : NSObject
// 头像
@property (nonatomic, strong)NSString *headImage;
// 礼物
@property (nonatomic, strong)UIImage *giftImage;
// 送礼物者
@property (nonatomic, copy)NSString *name;
// 礼物名称
@property (nonatomic, copy)NSString *giftName;
// 礼物个数
@property (nonatomic, assign)NSInteger giftCount;

@end
