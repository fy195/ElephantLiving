//
//  ElWatchViewController.h
//  ElephantLiving
//
//  Created by dllo on 16/10/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseViewController.h"
@class LiveRoom;
@interface ElWatchViewController : ElBaseViewController
@property (nonatomic, strong) LiveRoom *liveRoom;
@property (nonatomic, strong) UIImage *placeholderImage;
@end
