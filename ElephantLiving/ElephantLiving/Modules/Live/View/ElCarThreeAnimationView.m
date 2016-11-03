//
//  ElCarThreeAnimationView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElCarThreeAnimationView.h"

@implementation ElCarThreeAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)animationComplete:(CompleteBlock)completeBlock {

    self.image = [UIImage imageNamed:@"ferrari"];
    self.giftAnimating = YES;
    
    [UIView animateWithDuration:2.0 animations:^{
        self.frame = CGRectMake(120, 200, 250, 130);
    }];
    
    [UIView animateWithDuration:1.0 delay:2.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(-250, 400, 250, 130);
    } completion:^(BOOL finished) {
        completeBlock(self);
        self.giftAnimating = NO;
    }];


}

@end
