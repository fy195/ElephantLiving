//
//  ElLivingTopView.h
//  ElephantLiving
//
//  Created by dllo on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ElLivingTopViewDelegate <NSObject>

- (void)presentBriefView;

@end

@interface ElLivingTopView : UIView

@property (nonatomic, strong) UIImage *headerImage;

@property (nonatomic, strong) NSNumber *watchCount;

@property (nonatomic, assign) id<ElLivingTopViewDelegate>delegate;

+ (instancetype)elLivingTopView;

@end
