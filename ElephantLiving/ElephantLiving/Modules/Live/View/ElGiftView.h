//
//  ElGiftView.h
//  ElephantLiving
//
//  Created by Omaiga on 2016/11/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ElGiftViewDelegate <NSObject>

- (void)animationWithItemCount:(NSInteger)itemCount;

@end

@interface ElGiftView : UIView

@property (nonatomic, strong)UIButton *sendButton;
@property (nonatomic, assign) id<ElGiftViewDelegate>delegate;

@end
