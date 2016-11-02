//
//  ElHotViewController.h
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseViewController.h"

@protocol ElHotViewControllerDelegate <NSObject>

- (void)presentWatchController;

@end

@interface ElHotViewController : ElBaseViewController
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) id<ElHotViewControllerDelegate>delegate;

@end
