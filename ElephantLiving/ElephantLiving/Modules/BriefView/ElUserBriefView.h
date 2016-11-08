//
//  ElUserBriefView.h
//  ElephantLiving
//
//  Created by dllo on 16/11/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElBaseView.h"

@protocol ElUserBriefViewDelegate <NSObject>

- (void)report;

- (void)follow:(BOOL)isFollow;

@end

@interface ElUserBriefView : ElBaseView
@property (nonatomic, assign) id<ElUserBriefViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber *follower;
@property (nonatomic, strong) NSNumber *followee;
+ (instancetype)elUserBriefView;

@end
