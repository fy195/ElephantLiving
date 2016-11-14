//
//  ElFireworksAnimationView.m
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElFireworksAnimationView.h"
#import "ElMacro.h"

@interface ElFireworksAnimationView ()

@property (nonatomic, strong)ElBaseGiftAnimationView *fireImageView;

@property (nonatomic, strong)ElBaseGiftAnimationView *redImageView;

@property (nonatomic, strong)ElBaseGiftAnimationView *purpleImageView;

@property (nonatomic, strong)ElBaseGiftAnimationView *yellowImageView;

@property (nonatomic, strong)ElBaseGiftAnimationView *greenImageView;

@end

@implementation ElFireworksAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fireImageView = [[ElBaseGiftAnimationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25, SCREEN_HEIGHT * 0.6 - 200, 200, 200)];
        [self addSubview:_fireImageView];
        
        self.redImageView = [[ElBaseGiftAnimationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.17, SCREEN_HEIGHT * 0.245, 100, 100)];
        _redImageView.image = [UIImage imageNamed:@"fireworks_11.png"];
        _redImageView.alpha = 0;
        [self addSubview:_redImageView];
        
        self.purpleImageView = [[ElBaseGiftAnimationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.29, SCREEN_HEIGHT * 0.27, 100, 100)];
        _purpleImageView.image = [UIImage imageNamed:@"fireworks_12.png"];
        _purpleImageView.alpha = 0;
        [self addSubview:_purpleImageView];
        
        self.yellowImageView = [[ElBaseGiftAnimationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.35, SCREEN_HEIGHT * 0.235, 100, 100)];
        _yellowImageView.image = [UIImage imageNamed:@"fireworks_13.png"];
        _yellowImageView.alpha = 0;
        [self addSubview:_yellowImageView];
        
        self.greenImageView = [[ElBaseGiftAnimationView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.58, SCREEN_HEIGHT * 0.2, 100, 100)];
        _greenImageView.image = [UIImage imageNamed:@"fireworks_14.png"];
        _greenImageView.alpha = 0;
        [self addSubview:_greenImageView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)animationComplete:(CompleteBlock)completeBlock {

    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"fireworks_%d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    
    NSTimeInterval time = 0.2 * imageArray.count;
    _fireImageView.animationImages = imageArray;
    _fireImageView.animationDuration = time;
    _fireImageView.animationRepeatCount = 1;
    [_fireImageView startAnimating];
    self.giftAnimating = YES;
    
    // 红色烟花动作
    [UIView animateWithDuration:1 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _redImageView.frame = CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_HEIGHT * 0.176, 200, 200);
        _redImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [_redImageView removeFromSuperview];
    }];
    
    
    
    // 紫色烟花动作
    [UIView animateWithDuration:1 delay:1.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _purpleImageView.frame = CGRectMake(SCREEN_WIDTH * 0.17, SCREEN_HEIGHT * 0.2, 200, 200);
        _purpleImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [_purpleImageView removeFromSuperview];
    }];
    
    // 黄色烟花动作
    [UIView animateWithDuration:1 delay:1.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _yellowImageView.frame = CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT * 0.125, 200, 200);
        _yellowImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [_yellowImageView removeFromSuperview];
    }];
    
    // 绿色烟花动作
    [UIView animateWithDuration:1 delay:1.65 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _greenImageView.frame = CGRectMake(SCREEN_WIDTH * 0.46, SCREEN_HEIGHT * 0.135, 200, 200);
        _greenImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [_greenImageView removeFromSuperview];
    }];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        completeBlock(self);
        self.giftAnimating = NO;
        
    });
    
    

}

@end
