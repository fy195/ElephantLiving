//
//  ElHotTableViewCell.h
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElHotTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, assign) NSInteger viewCount;
@property (nonatomic, strong) UIImage *coverImage;

@end
