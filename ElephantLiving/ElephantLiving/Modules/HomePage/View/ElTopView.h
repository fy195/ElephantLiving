//
//  ElTopView.h
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ElTopView : UIView

/** 下划线 */
@property (nonatomic, strong)UIView *underLine;

@property (nonatomic, strong) UIButton *hotButton;

@property (nonatomic, strong) UIButton *newestButton;

@property (nonatomic, strong) UIButton *listButton;

- (void)click:(UIButton *)btn;

@property (nonatomic, strong)UIButton *selectedBtn;

@end
