//
//  ElWatchGiftView.h
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ElWatchGiftViewDelegate <NSObject>

- (void)animationWithItemCount:(NSInteger)itemCount;

@end

@interface ElWatchGiftView : UIView

@property (nonatomic, strong)UIButton *sendButton;
@property (nonatomic, assign) id<ElWatchGiftViewDelegate>delegate;

@end
