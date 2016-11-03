//
//  ShakeLabel.h
//  动画
//
//  Created by Omaiga on 2016/11/1.
//  Copyright © 2016年 Omaiga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeLabel : UILabel
// 动画时间
@property (nonatomic,assign) NSTimeInterval duration;
// 描边颜色
@property (nonatomic,strong) UIColor *borderColor;

- (void)startAnimWithDuration:(NSTimeInterval)duration;

@end
