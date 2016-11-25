//
//  ElHouseAniamtionView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHouseAniamtionView.h"

@implementation ElHouseAniamtionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)animationComplete:(CompleteBlock)completeBlock {

    self.image = [UIImage imageNamed:@"18888_anima_img1"];
    self.alpha = 0;
    self.giftAnimating = YES;
    
    
    [UIView animateWithDuration:3.0 animations:^{
        self.frame = CGRectMake(40, 190, [UIScreen mainScreen].bounds.size.width  - 80, 320);
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        completeBlock(self);
        self.giftAnimating = NO;
    }];


}

@end
