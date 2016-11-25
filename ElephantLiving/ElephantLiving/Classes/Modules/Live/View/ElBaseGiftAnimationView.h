//
//  ElBaseGiftAnimationView.h
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock)(UIImageView *currentView);

@interface ElBaseGiftAnimationView : UIImageView

@property (nonatomic, assign, getter=isGiftAnimating) BOOL giftAnimating;


- (void)animationComplete:(CompleteBlock)completeBlock;

@end
