//
//  ElHotTableViewCell.h
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElHotTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *iconImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, strong) NSString *coverImage;

@end
