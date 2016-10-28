//
//  ElEndLiving.h
//  ElephantLiving
//
//  Created by Omaiga on 16/10/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElEndLiving : UIView

@property (nonatomic, strong) UILabel *endLabel;

@property (nonatomic, strong) UILabel *timeTextLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) UILabel *viewTextLabel;

@property (nonatomic, strong) UILabel *viewLabel;

@property (nonatomic, copy) NSString *view_count;

@property (nonatomic, strong) UIButton *backButton;

@end
