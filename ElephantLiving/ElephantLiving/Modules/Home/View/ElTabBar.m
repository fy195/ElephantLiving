//
//  ElTabBar.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElTabBar.h"



@interface ElTabBar ()

@property (nonatomic, strong) NSArray *norImage;

@property (nonatomic, strong) NSArray *seleImage;

@end

@implementation ElTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.norImage = @[@"1",@"1",@"1"];
        self.seleImage = @[@"2",@"2",@"2"];
        
        CGFloat width = SCREEN_WIDTH / 4;
        
        
        for (NSInteger i = 0; i< 3; i++)
        {
            self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            //按钮：
            [_btn setImage:[UIImage imageNamed:[_norImage objectAtIndex:i]]  forState:UIControlStateNormal];
            if (i == 0) {
                _btn.selected = YES;
            }
            [_btn setImage:[UIImage imageNamed:[_seleImage objectAtIndex:i]] forState:UIControlStateSelected];
            
            _btn.tag = i+1000;
            
            [_btn addTarget:self action:@selector(TapBtn:) forControlEvents:UIControlEventTouchUpInside];
            _btn.size = CGSizeMake(self.height / 2, self.height / 2);
            if (i == 1) {
                _btn.center = self.center;
                _btn.size = CGSizeMake(self.height / 3 * 2, self.height / 3 * 2);
            }
            if (i == 0) {
                _btn.centerX = width;
            }
            if (i == 2) {
                _btn.centerX = width * 3;
            }
            
            _btn.centerY = self.height / 2;
            [self addSubview:_btn];
        }
    }
    return self;
}
- (void)TapBtn:(UIButton *)button {
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:i+1000];
        btn.selected = NO;
    }
    button.selected = YES;
    _tagBtn =button.tag;
    [self.delegateOfPresent getButtonTag:_tagBtn];
    
    
//    self.selectedIndex = _bottomView.tagBtn - 1000;
    
    
}

@end
