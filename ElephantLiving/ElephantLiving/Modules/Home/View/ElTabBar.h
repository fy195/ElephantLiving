//
//  ElTabBar.h
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ElTabBarDelegate <NSObject>
@required
- (void)getButtonTag:(NSInteger)tag;
@end

@interface ElTabBar : UITabBar

@property (nonatomic,assign) NSInteger tagBtn;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, assign) id<ElTabBarDelegate>delegateOfPresent;
@end
