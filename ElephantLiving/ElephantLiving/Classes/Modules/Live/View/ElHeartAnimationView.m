//
//  ElHeartAnimationView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHeartAnimationView.h"

@interface ElHeartAnimationView ()

@end

@implementation ElHeartAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)animationComplete:(CompleteBlock)completeBlock {
    NSMutableArray *heartImageArray = [NSMutableArray array];
    for (int i = 1; i <= 20; i++) {
        NSString *heartImageName = [NSString stringWithFormat:@"gift_heart_%d.png", i];
        UIImage *image = [UIImage imageNamed:heartImageName];
        [heartImageArray addObject:image];
    }
    
    NSTimeInterval time = 0.10 * heartImageArray.count;
    self.animationImages = heartImageArray;
    self.animationDuration = time;
    self.animationRepeatCount = 1;
    self.giftAnimating = YES;
    [self startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.giftAnimating = NO;
        completeBlock(self);
    });
    
}

@end
