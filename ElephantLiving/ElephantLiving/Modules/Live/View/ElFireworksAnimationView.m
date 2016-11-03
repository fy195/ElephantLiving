//
//  ElFireworksAnimationView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElFireworksAnimationView.h"

@implementation ElFireworksAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)animationComplete:(CompleteBlock)completeBlock {

    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i <= 14; i++) {
        NSString *imageName = [NSString stringWithFormat:@"fireworks_%d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    
    NSTimeInterval time = 0.15 * imageArray.count;
    self.animationImages = imageArray;
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
