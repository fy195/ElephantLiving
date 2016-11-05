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

- (void)follow;

@end

@interface ElUserBriefView : ElBaseView
@property (nonatomic, assign) id<ElUserBriefViewDelegate>delegate;
+ (instancetype)elUserBriefView;

@end
