//
//  ElCarTwoAnimationView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElCarTwoAnimationView.h"

@implementation ElCarTwoAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)animationComplete:(CompleteBlock)completeBlock {

    self.image = [UIImage imageNamed:@"car"];
    self.giftAnimating = YES;
    
    [UIView animateWithDuration:2.0 animations:^{
        self.frame = CGRectMake(80, 250, 250, 130);
    }];
    
    [UIView animateWithDuration:1.0 delay:2.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 400, 250, 130);
    } completion:^(BOOL finished) {
        completeBlock(self);
        self.giftAnimating = NO;
        
    }];


}

@end
