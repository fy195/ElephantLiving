//
//  ElNewViewController.h
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseViewController.h"
@class ElLiveRoom;

@protocol ElNewViewControllerDelegate <NSObject>

- (void)presentWatchControllerWithElLiveRoom:(ElLiveRoom *)liveRoom;

@end
@interface ElNewViewController : ElBaseViewController
@property (nonatomic, assign) id<ElNewViewControllerDelegate>delegate;
@end
