//
//  ElWatchViewController.h
//  ElephantLiving
//
//  Created by dllo on 16/10/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseViewController.h"
@class ElLivingRoom;
@interface ElWatchViewController : ElBaseViewController
@property (nonatomic, strong) ElLivingRoom *liveRoom;
@property (nonatomic, strong) UIImage *placeholderImage;
@end
